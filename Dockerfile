FROM ubuntu:18.04

ENV ETL_PATH /root/etlegacy
ENV ETL_FOLDER etlegacy-v2.79.0-x86_64
ENV ETL_FILENAME $ETL_FOLDER.tar.gz
ENV ETL_URL https://www.etlegacy.com/download/file/344
ENV PAK_MIRROR http://aciz.etjump.com/etlserver/27960/etmain/
ENV PAK_MIRROR2 https://www.harryhomers.org/et/download/etmain/

RUN apt-get update -y && apt-get install -y wget
RUN wget -nv -O $ETL_FILENAME $ETL_URL
RUN tar -xzf $ETL_FILENAME && rm -f $ETL_FILENAME
RUN mv $ETL_FOLDER $ETL_PATH

WORKDIR $ETL_PATH/etmain
RUN wget -nv $PAK_MIRROR/pak0.pk3 \
             $PAK_MIRROR/pak1.pk3 \
             $PAK_MIRROR/pak2.pk3 \
             $PAK_MIRROR/mp_bin.pk3 \
             $PAK_MIRROR/braundorf_b4.pk3 \
             $PAK_MIRROR2/CTF_Multi2.pk3 \
             $PAK_MIRROR/erdenberg_b3.pk3 \
             $PAK_MIRROR/escape2.pk3 \
             $PAK_MIRROR/et_beach.pk3 \
             $PAK_MIRROR2/kothet2.pk3 \
             $PAK_MIRROR2/multi_huntplace.pk3 \
             $PAK_MIRROR/sw_goldrush_te.pk3 \
             $PAK_MIRROR/te_valhalla.pk3 \
             $PAK_MIRROR/tc_base.pk3 \
             $PAK_MIRROR/mp_sillyctf.pk3 \
             $PAK_MIRROR/etl_adlernest_v3.pk3 \
             $PAK_MIRROR/etl_frostbite_v16.pk3 \
             $PAK_MIRROR/etl_ice_v10.pk3 \
             $PAK_MIRROR/etl_sp_delivery_v3.pk3 \
             $PAK_MIRROR/etl_supply_v8.pk3

COPY etl_server.cfg $ETL_PATH/etmain/

ARG SERVER_PASSWORD
ARG REFEREE_PASSWORD
ARG RCON_PASSWORD

RUN sed -i -e "s/changemegpw/$SERVER_PASSWORD/g ; s/changemerefpw/$REFEREE_PASSWORD/g ; s/changemerconpw/$RCON_PASSWORD/g" $ETL_PATH/etmain/etl_server.cfg

EXPOSE 27960/udp

WORKDIR $ETL_PATH

ENTRYPOINT ./etlded +exec etl_server.cfg
