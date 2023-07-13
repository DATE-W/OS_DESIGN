#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
const int maxN = 35;
int isfirst = 1;
int mypipe[2], frd, fwt;

long num;//每次被筛选的数
long prime;
int main(int argc, char* argv[])
{  
    //第一个进程进行特殊处理
    if (isfirst)
    {
        pipe(mypipe);
        frd = mypipe[0];//读取端
        fwt = mypipe[1];//写入端
        isfirst = 0;
        for (num = 2; num <= maxN; num++)
        {
            write(fwt, (void *)&num, 8);
        }
        close(fwt);
    }

    if (fork() == 0)
    {
        if (read(frd, (void *)&prime, 8))
        {
            printf("prime %d\n", prime);
            pipe(mypipe);
            fwt = mypipe[1];
        }
        while (read(frd, (void *)&num, 8))
        {
            if (num % prime != 0)
            write(fwt, (void *)&num, 8);
        }
        frd = mypipe[0];
        close(fwt);
        main(argc, argv);
    }
    else
    {
        wait((int*)0);
        close(frd);
    }
    exit(0);
}