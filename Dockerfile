FROM ubuntu:18.04

ENV ETL_PATH /root/etlegacy
ENV ETL_FOLDER etlegacy-v2.79.0-x86_64
ENV ETL_FILENAME $ETL_FOLDER.tar.gz
ENV ETL_URL https://www.etlegacy.com/download/file/344
ENV PAK_MIRROR http://aciz.etjump.com/etlserver/27960/etmain/

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
             $PAK_MIRROR/et_beach.pk3 \
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
RUN sed -i "s/changemegpw/$SERVER_PASSWORD/" $ETL_PATH/etmain/etl_server.cfg
ARG REFEREE_PASSWORD
RUN sed -i "s/changemerconpw/$REFEREE_PASSWORD/" $ETL_PATH/etmain/etl_server.cfg
ARG RCON_PASSWORD
RUN sed -i "s/changemerefpw/$RCON_PASSWORD/" $ETL_PATH/etmain/etl_server.cfg

EXPOSE 27960/udp

WORKDIR $ETL_PATH

ENTRYPOINT ./etlded +exec etl_server.cfg
