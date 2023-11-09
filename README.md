# ONLINE BOOKSTORE LEASE APPLICATION
### Running with docker 
##### Prerequisite: 
1. Installed Docker
2. Installed Docker Compose

##### Steps
1. Navigate to the project's root folder (where we have solution files)
2. Run ``` docker build -t vgu.pe.2023.application -f .\Dockerfile.application .``` 
3. Run ```  docker compose -f "vgu.pe.docker.compose.yml" up -d ``` to bring the project up
4. Open browser and navigate to ``` http://localhost:7124 ``` to access the web site 
5. Enjoy 
6. Run ```  docker compose -f "vgu.pe.docker.compose.yml" down ``` to bring the project down

Note: if there is existing an error "no matching manifest for window", please switch to Linux containers in the icon Docker Desktop on the taskbar.# LibraryApp
