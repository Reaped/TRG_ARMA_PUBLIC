//Initializes variables neccessary for using all other ws functions
//09.08.2017
//Author: Sparker

ws_squareSize = 500;
ws_mapSizeX = 27000; //30000; //Size in meters
ws_mapSizeY = 22000; //30000;

ws_gridSizeX = floor(ws_mapSizeX / ws_squareSize); //Size of the grid measured in squares
ws_gridSizeY = floor(ws_mapSizeY / ws_squareSize);
ws_gridStartX = 2000;
ws_gridStartY = 4000;