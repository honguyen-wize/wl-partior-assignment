package com.wizeline.assigments.utils;

public class NodeServerUtils {
   public static String getNodeStatus(String bic, String status){
      return "Tessera".equalsIgnoreCase(status) ? "" : bic;
   }
}
