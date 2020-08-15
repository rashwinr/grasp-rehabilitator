void filewriter(){
  output.println( nfc(lf,2) + "," + nfc(grip,2) + "," + nfc(lfr,2) + ", " + nfc(gripr,2));  // Write the X coordinate to the file 
  if(print && !started)
{
  output.flush();  // Writes the remaining data to the file
  output.close();
}
}