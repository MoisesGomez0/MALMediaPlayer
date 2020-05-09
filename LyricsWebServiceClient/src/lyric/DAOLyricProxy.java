package lyric;

public class DAOLyricProxy implements lyric.DAOLyric {
  private String _endpoint = null;
  private lyric.DAOLyric dAOLyric = null;
  
  public DAOLyricProxy() {
    _initDAOLyricProxy();
  }
  
  public DAOLyricProxy(String endpoint) {
    _endpoint = endpoint;
    _initDAOLyricProxy();
  }
  
  private void _initDAOLyricProxy() {
    try {
      dAOLyric = (new lyric.DAOLyricServiceLocator()).getDAOLyric();
      if (dAOLyric != null) {
        if (_endpoint != null)
          ((javax.xml.rpc.Stub)dAOLyric)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
        else
          _endpoint = (String)((javax.xml.rpc.Stub)dAOLyric)._getProperty("javax.xml.rpc.service.endpoint.address");
      }
      
    }
    catch (javax.xml.rpc.ServiceException serviceException) {}
  }
  
  public String getEndpoint() {
    return _endpoint;
  }
  
  public void setEndpoint(String endpoint) {
    _endpoint = endpoint;
    if (dAOLyric != null)
      ((javax.xml.rpc.Stub)dAOLyric)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
    
  }
  
  public lyric.DAOLyric getDAOLyric() {
    if (dAOLyric == null)
      _initDAOLyricProxy();
    return dAOLyric;
  }
  
  public java.lang.String getAPILyric(java.lang.String songName, java.lang.String artistName) throws java.rmi.RemoteException{
    if (dAOLyric == null)
      _initDAOLyricProxy();
    return dAOLyric.getAPILyric(songName, artistName);
  }
  
  public java.lang.String getStaticLyric(java.lang.String songName, java.lang.String artistName) throws java.rmi.RemoteException{
    if (dAOLyric == null)
      _initDAOLyricProxy();
    return dAOLyric.getStaticLyric(songName, artistName);
  }
  
  
}