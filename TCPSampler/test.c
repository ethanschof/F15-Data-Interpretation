#include <winsock2.h>
#include <windows.h>
#include <tlhelp32.h>
#include <stdio.h>
#include <unistd.h>
#include <tchar.h>

#define MAX 42000
#define PORT 2023
char SERVERIP[16];

//TCP Client for Windows
void GetandSendData(SOCKET sockfd)
{
    printf("First 36 bytes from Packet data\n==================================================\n");
    unsigned char* buff = (char*)malloc(MAX * sizeof(char));
    int n = 0;
    while(1){
        memset(buff, 0, MAX);
        recv(sockfd, buff, MAX, 0);
        printf("%05d) ", n);
        for(int i = 0; i < 36; i++){
            printf("%02hhX ", buff[i]);
        }
        printf("\n");
        n++;
    }
}

int SetUpTCPClient()
{
    //Set Up Windows socket for connection
    WSADATA wsa;
    SOCKET sockfd, connfd;
    struct sockaddr_in servaddr;
    int len;

    if (WSAStartup(MAKEWORD(2,2),&wsa) != 0)
    {
        printf("WSA Failed. Error Code : %d",WSAGetLastError());
        return 1;
    }

    sockfd = socket(AF_INET, SOCK_STREAM, 0);
    if (sockfd == INVALID_SOCKET) {
        printf("Socket creation failed.\n");
        exit(0);
    }
    else
        printf("Socket successfully created.\n");

    memset(&servaddr, 0, sizeof(servaddr));
    servaddr.sin_family = AF_INET;
    servaddr.sin_addr.S_un.S_addr = inet_addr(SERVERIP);
    servaddr.sin_port = htons(PORT);

    //try to connect to server
    int waitingToConnect = 1;
    while(waitingToConnect){
        printf("Trying to Connect to Server on port %d at IP %s ... ", PORT, SERVERIP);
        if(connect(sockfd, (struct sockaddr *)&servaddr, sizeof(servaddr)) == SOCKET_ERROR) {
            printf("Failed.\n");
            Sleep(500);
        }else{
            printf("Success!\n");
            waitingToConnect = 0;
        }
    }

    GetandSendData(sockfd);
    closesocket(sockfd);
    WSACleanup();
}

int main(int argc, char const *argv[])
{
    printf("ch10 sampler client tester\n");
    printf("Enter IP address: ");
    int n = 0;
    while ((SERVERIP[n++] = getchar()) != '\n')
                ;
    SERVERIP[n-1] = '\0';
    SetUpTCPClient();

    return 0;
}
