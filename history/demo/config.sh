#!/bin/bash
# 
# chenyongkang@kedacom

. /etc/profile
. ./lib

path=/usr/etc/config/conf/mcucfg.ini
cfg_path=$(get_prop $1 appConfFile)

mcuLocalInfo_mcuCheckLinkTime=$(get_prop $cfg_path mcuLocalInfo_mcuCheckLinkTime)
set_field_value $path  mcuLocalInfo mcuCheckLinkTime $mcuLocalInfo_mcuCheckLinkTime

mcuLocalInfo_mcuCheckLinkTimes=$(get_prop $cfg_path mcuLocalInfo_mcuCheckLinkTimes)
set_field_value $path  mcuLocalInfo mcuCheckLinkTimes $mcuLocalInfo_mcuCheckLinkTimes

mcuLocalInfo_mcuRefreshListTime=$(get_prop $cfg_path mcuLocalInfo_mcuRefreshListTime)
set_field_value $path  mcuLocalInfo mcuRefreshListTime $mcuLocalInfo_mcuRefreshListTime

mcuLocalInfo_mcuRefreshTime=$(get_prop $cfg_path mcuLocalInfo_mcuRefreshTime)
set_field_value $path  mcuLocalInfo mcuRefreshTime $mcuLocalInfo_mcuRefreshTime

mcuLocalInfo_mcuAudioRefreshTime=$(get_prop $cfg_path mcuLocalInfo_mcuAudioRefreshTime)
set_field_value $path  mcuLocalInfo mcuAudioRefreshTime $mcuLocalInfo_mcuAudioRefreshTime

mcuLocalInfo_mcuVideoRefreshTime=$(get_prop $cfg_path mcuLocalInfo_mcuVideoRefreshTime)
set_field_value $path  mcuLocalInfo mcuVideoRefreshTime $mcuLocalInfo_mcuVideoRefreshTime

mcuLocalInfo_mcuIsSaveBand=$(get_prop $cfg_path mcuLocalInfo_mcuIsSaveBand)
mcuLocalInfo_mcuIsSaveBand=$(get_radio_value $mcuLocalInfo_mcuIsSaveBand)
set_field_value $path  mcuLocalInfo mcuIsSaveBand $mcuLocalInfo_mcuIsSaveBand

mcuLocalInfo_mcuIsNPlusMode=$(get_prop $cfg_path mcuLocalInfo_mcuIsNPlusMode)
mcuLocalInfo_mcuIsNPlusMode=$(get_radio_value $mcuLocalInfo_mcuIsNPlusMode)
set_field_value $path  mcuLocalInfo mcuIsNPlusMode $mcuLocalInfo_mcuIsNPlusMode

mcuLocalInfo_mcuIsNPlusBackupMode=$(get_prop $cfg_path mcuLocalInfo_mcuIsNPlusBackupMode)
mcuLocalInfo_mcuIsNPlusBackupMode=$(get_radio_value $mcuLocalInfo_mcuIsNPlusBackupMode)
set_field_value $path  mcuLocalInfo mcuIsNPlusBackupMode $mcuLocalInfo_mcuIsNPlusBackupMode

mcuLocalInfo_mcuNPlusMcuIp=$(get_prop $cfg_path mcuLocalInfo_mcuNPlusMcuIp)
set_field_value $path  mcuLocalInfo mcuNPlusMcuIp $mcuLocalInfo_mcuNPlusMcuIp

mcuLocalInfo_mcuNPlusRtdTime=$(get_prop $cfg_path mcuLocalInfo_mcuNPlusRtdTime)
set_field_value $path  mcuLocalInfo mcuNPlusRtdTime $mcuLocalInfo_mcuNPlusRtdTime

mcuLocalInfo_mcuNPlusRtdNum=$(get_prop $cfg_path mcuLocalInfo_mcuNPlusRtdNum)
set_field_value $path  mcuLocalInfo mcuNPlusRtdNum $mcuLocalInfo_mcuNPlusRtdNum

mcuLocalInfo_mcuIsNPlusRollBack=$(get_prop $cfg_path mcuLocalInfo_mcuIsNPlusRollBack)
mcuLocalInfo_mcuIsNPlusRollBack=$(get_radio_value $mcuLocalInfo_mcuIsNPlusRollBack)
set_field_value $path  mcuLocalInfo mcuIsNPlusRollBack $mcuLocalInfo_mcuIsNPlusRollBack

mcuLocalInfo_mcuIsShowMMcuMtList=$(get_prop $cfg_path mcuLocalInfo_mcuIsShowMMcuMtList)
mcuLocalInfo_mcuIsShowMMcuMtList=$(get_radio_value $mcuLocalInfo_mcuIsShowMMcuMtList)
set_field_value $path  mcuLocalInfo mcuIsShowMMcuMtList $mcuLocalInfo_mcuIsShowMMcuMtList

mcuLocalInfo_mcuAdminLevel=$(get_prop $cfg_path mcuLocalInfo_mcuAdminLevel)
set_field_value $path  mcuLocalInfo mcuAdminLevel $mcuLocalInfo_mcuAdminLevel

mcuLocalInfo_mcuIsMMcuSpeaker=$(get_prop $cfg_path mcuLocalInfo_mcuIsMMcuSpeaker)
mcuLocalInfo_mcuIsMMcuSpeaker=$(get_radio_value $mcuLocalInfo_mcuIsMMcuSpeaker)
set_field_value $path  mcuLocalInfo mcuIsMMcuSpeaker $mcuLocalInfo_mcuIsMMcuSpeaker

mcuLocalInfo_mcunetRecvStartPort=$(get_prop $cfg_path mcuLocalInfo_mcunetRecvStartPort)
set_field_value $path  mcuLocalInfo mcunetRecvStartPort $mcuLocalInfo_mcunetRecvStartPort

mcuLocalInfo_mcuLocalConfNameShowType=$(get_prop $cfg_path mcuLocalInfo_mcuLocalConfNameShowType)
mcuLocalInfo_mcuLocalConfNameShowType=$(get_radio_value $mcuLocalInfo_mcuLocalConfNameShowType)
set_field_value $path  mcuLocalInfo mcuLocalConfNameShowType $mcuLocalInfo_mcuLocalConfNameShowType


mcuNetwork_UmuIp=$(get_prop $cfg_path mcuNetwork_UmuIp)
set_field_value $path  mcuNetwork UmuIp $mcuLocalInfo_UmuIp

mcuNetwork_mcuLocalInnerIp=$(get_prop $cfg_path mcuNetwork_mcuLocalInnerIp)
set_field_value $path  mcuNetwork mcuLocalInnerIp $mcuLocalInfo_mcuLocalInnerIp

mcuNetwork_mcuOtherInnerIp=$(get_prop $cfg_path mcuNetwork_mcuOtherInnerIp)
set_field_value $path  mcuNetwork mcuOtherInnerIp $mcuLocalInfo_mcuOtherInnerIp

mcuPrsTimeSpan_span1=$(get_prop $cfg_path mcuPrsTimeSpan_span1)
set_field_value $path  mcuPrsTimeSpan span1 $mcuPrsTimeSpan_span1

mcuPrsTimeSpan_span2=$(get_prop $cfg_path mcuPrsTimeSpan_span2)
set_field_value $path  mcuPrsTimeSpan span2 $mcuPrsTimeSpan_span2

mcuPrsTimeSpan_span3=$(get_prop $cfg_path mcuPrsTimeSpan_span3)
set_field_value $path  mcuPrsTimeSpan span3 $mcuPrsTimeSpan_span3

mcuPrsTimeSpan_span4=$(get_prop $cfg_path mcuPrsTimeSpan_span4)
set_field_value $path  mcuPrsTimeSpan span4 $mcuPrsTimeSpan_span4


mcuQosConfigure_mcuQosType=$(get_prop $cfg_path mcuQosConfigure_mcuQosType)
mcuQosConfigure_mcuQosType=$(get_radio_value $mcuQosConfigure_mcuQosType)
set_field_value $path  mcuQosConfigure mcuQosType $mcuQosConfigure_mcuQosType

mcuQosConfigure_mcuAudioLevel=$(get_prop $cfg_path mcuQosConfigure_mcuAudioLevel)
set_field_value $path  mcuQosConfigure mcuAudioLevel $mcuQosConfigure_mcuAudioLevel

mcuQosConfigure_mcuVideoLevel=$(get_prop $cfg_path mcuQosConfigure_mcuVideoLevel)
set_field_value $path  mcuQosConfigure mcuVideoLevel $mcuQosConfigure_mcuVideoLevel

mcuQosConfigure_mcuDataLevel=$(get_prop $cfg_path mcuQosConfigure_mcuDataLevel)
set_field_value $path  mcuQosConfigure mcuDataLevel $mcuQosConfigure_mcuDataLevel

mcuQosConfigure_mcuSignalLevel=$(get_prop $cfg_path mcuQosConfigure_mcuSignalLevel)
set_field_value $path  mcuQosConfigure mcuSignalLevel $mcuQosConfigure_mcuSignalLevel

mcuQosConfigure_mcuIpServiceType=$(get_prop $cfg_path mcuQosConfigure_mcuIpServiceType)
set_field_value $path  mcuQosConfigure mcuIpServiceType $mcuQosConfigure_mcuIpServiceType