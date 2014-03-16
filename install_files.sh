#!/bin/sh

#  install_files.sh
#
#  Created by Andy Arvanitis on 3/15/14.
#

if [ "$ACTION" = "clean" ]
then
  rm -rf "${DSTROOT}/${INSTALL_PATH}/${PLUGIN_NAME}"
  rm -rf "${DSTROOT}/${TEMPLATES_INSTALL_PATH}/${TEMPLATES_FOLDER_NAME}"
  rm -rf "${OBJROOT}/${DMG_MOUNTPOINT}"

else

  mkdir "${OBJROOT}/${DMG_MOUNTPOINT}"
  
  curl -L "${DMG_ARCHIVE_LOCATION}/${DMG_FILE}" -o "${OBJROOT}/${DMG_FILE}"
  
  hdiutil attach -nobrowse -mountpoint "${OBJROOT}/${DMG_MOUNTPOINT}" "${OBJROOT}/${DMG_FILE}"
  
  PLUGIN_LOCATION=`find "${OBJROOT}/${DMG_MOUNTPOINT}" -name "${PLUGIN_NAME}" 2>/dev/null`
  
  cp -R -p "${PLUGIN_LOCATION}" "${DSTROOT}/${INSTALL_PATH}/"
  
  TEMPLATES_LOCATION=`find "${OBJROOT}/${DMG_MOUNTPOINT}" -name "${TEMPLATES_FOLDER_NAME}" 2>/dev/null`
  
  cp -R -p "${TEMPLATES_LOCATION}" "${DSTROOT}/${TEMPLATES_INSTALL_PATH}/"
  
  hdiutil detach "${OBJROOT}/${DMG_MOUNTPOINT}"
  
  rm -rf "${OBJROOT}/${DMG_FILE}"
  
  rm -rf "${OBJROOT}/${DMG_MOUNTPOINT}"

fi

