/**
 * DAOLyric.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package lyric;

public interface DAOLyric extends java.rmi.Remote {
    public java.lang.String getAPILyric(java.lang.String songName, java.lang.String artistName) throws java.rmi.RemoteException;
    public java.lang.String getStaticLyric(java.lang.String songName, java.lang.String artistName) throws java.rmi.RemoteException;
}
