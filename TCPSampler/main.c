#include <winsock2.h>
#include <windows.h>
#include <tlhelp32.h>
#include <stdio.h>
#pragma comment(lib, "ws2_32.lib")

#define MAX 5840
#define PORT 2023

void printTitle(){

    
printf("\x1b[33m  _______ _____ _____     _____                       _           \n");
printf(" |__   __/ ____|  __ \\   / ____|                     | |          \n");
printf("    | | | |    | |__) | | (___   __ _ _ __ ___  _ __ | | ___ _ __ \n");
printf("    | | | |    |  ___/   \\___ \\ / _` | '_ ` _ \\| '_ \\| |/ _ \\ '__|\n");
printf("    | | | |____| |       ____) | (_| | | | | | | |_) | |  __/ |   \n");
printf("    |_|  \\_____|_|      |_____/ \\__,_|_| |_| |_| .__/|_|\\___|_|   \n");
printf("                                               | |            3.0 \n");
printf("\x1b[0m By C1C Colin Seymour         \x1b[33m                 |_|                \n\t\t\x1b[0mTCP Replayers made easy\n-----------------------------------------------------------------------\n\n");


}

unsigned char* extractData(FILE* fp, int numBytes){
    if(numBytes == 0){
        printf("Empty Packet\n");
        return "Empty Packet";
    }
    unsigned char *data = (unsigned char*)malloc(numBytes * sizeof(unsigned char));
    memset(data, 0, numBytes);
    for(int i = 0; i < numBytes; i++){
        data[i] = (unsigned char)fgetc(fp);
    }
    return data;
}

unsigned char* readch10File(FILE* fp, long* pSize){
    //read in first part and get total size
    unsigned char* header = extractData(fp, 4);
    //printf("%x %x %x %x\n", header[0], header[1], header[2],header[3]);
    if(header[0] != 37 || header[1] != 235){
        //good
        printf("Error: Bad header\n");
        exit(0);
    }
    unsigned char* packetSizeStr = extractData(fp, 4);
    long packetSize = packetSizeStr[0] + packetSizeStr[1]*256 + packetSizeStr[2]*4096 + packetSizeStr[3]*65536;
    //printf("Packet Size: %ld\n", packetSize);
    //printf("%x %x %x %x\n", packetSizeStr[0], packetSizeStr[1], packetSizeStr[2],packetSizeStr[3]);
    unsigned char* data = (unsigned char*)malloc(packetSize * sizeof(char));
    memset(data, 0, packetSize);

    //copy data to single string
    for(int i = 0; i < 4; i++){
        data[i] = header[i];
        data[i+4] = packetSizeStr[i];
    }
    free(header);
    free(packetSizeStr);

    unsigned char* restOfPacket = extractData(fp, packetSize-8);

    for(int i = 0; i < packetSize-8; i++){
        data[i+8] = restOfPacket[i];
    }

    //printf("%x %x %x %x ", data[0], data[1], data[2],data[3]);
    //printf("%x %x %x %x", data[4], data[5], data[6],data[7]);
    //printf("%x %x %x %x\n", data[8], data[9], data[10],data[11]);
    

    free(restOfPacket);

    *pSize = packetSize;
    return data;
}

int GetandSendData(SOCKET sockfd)
{
    //Get Filename from user
    char filename[256];
    char buff[MAX];
    int n = 0;
    printf("Enter ch10 filepath:  ");
    while ((filename[n++] = getchar()) != '\n' && n < 256)
        ;
    filename[n-1] = '\0'; //eliminate new line

    printf("Do you want to send one packet at a time? [y/n] ");
    char ans = getchar();

    //read in file as binary
    FILE* fp = fopen(filename, "rb");
    if(fp == NULL){
        printf("Failed to open %s\n", filename);
        return 0;
    }
    
    //get file length
    long fSize;
    fseek(fp, 0, SEEK_END);
    fSize = ftell(fp); 
    fseek(fp, 0, SEEK_SET);
    printf("File Size: %ld kB\n", fSize/1024);
    long fileLeft = fSize;

    printf("Press Enter to Begin...");
    getchar();
    getchar();

    printf("\n======================\n   Begin TCP Replay\n======================\n\n");
    int numpacketsSent = 0;
    while (fileLeft > 0)
    {
        long packetSize;
        char* packet = readch10File(fp, &packetSize);
        fileLeft -= packetSize;
        send(sockfd, packet, packetSize, 0);
        
        if(ans == 'y'){
            printf("\x1b[33mData sent)  \x1b[0m Packet Size = %ld\n", packetSize);
            for(int i =0; i < packetSize; i++){
                printf("%02hhX ", packet[i]);
            }
            printf("\n\nPress Enter to continue...");
            getchar();
        }else if(numpacketsSent%100 == 0){
            //Progress Bar
            printf("\33[2K\r");
            printf("Progress:  [");
            for(int j = 1; j < 26; j++){
                if(j >= 25 - ((double)fileLeft/(double)fSize)*25){printf(" ");}else{printf("=");}
            }printf("]");
        }

        free(packet);
        numpacketsSent++;
    }
    
    printf(" TCP Replay complete!\n");
    printf("Press Enter to Exit...");
    getchar();

    fclose(fp);
    return 1;
}

/**
 * Create a local TCP Connection
*/
int SetUpTCPServer()
{
    WSADATA wsa;
    SOCKET sockfd, connfd;
    struct sockaddr_in servaddr, cli;
    int len;

    if (WSAStartup(MAKEWORD(2,2),&wsa) != 0)
    {
        printf("Failed. Error Code : %d",WSAGetLastError());
        return 1;
    }

    sockfd = socket(AF_INET, SOCK_STREAM, 0);
    if (sockfd == INVALID_SOCKET) {
        printf("socket creation failed...\n");
        exit(0);
    }
    else
        printf("Socket successfully created..\n");
        
    memset(&servaddr, 0, sizeof(servaddr));
    servaddr.sin_family = AF_INET;
    servaddr.sin_addr.s_addr = htonl(INADDR_ANY);
    servaddr.sin_port = htons(PORT);
    if (bind(sockfd, (struct sockaddr*)&servaddr, sizeof(servaddr)) == SOCKET_ERROR) {
        printf("socket bind failed...\n");
        exit(0);
    }
    else
        printf("Socket successfully binded..\n");
    if (listen(sockfd, 5) == SOCKET_ERROR) {
        printf("listen failed...\n");
        exit(0);
    }
    else
        printf("Server listening..\n");
    len = sizeof(cli);
    connfd = accept(sockfd, (struct sockaddr*)&cli, &len);
    if (connfd == INVALID_SOCKET) {
        printf("server acccept failed...\n");
        exit(0);
    }
    else
        printf("server accepted the client.\n");
    int exitCondition = GetandSendData(connfd);
    closesocket(sockfd);
    WSACleanup();
    return exitCondition;
}

int main(int argc, char const *argv[])
{
    printTitle();
    //Open TCP Server
    system("ipconfig | findstr IPv4");
    SetUpTCPServer();
    return 0;
}
