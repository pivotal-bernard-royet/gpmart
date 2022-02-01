/*******************
 *
 * It will generate Date, Day, Month, Year, Weekday, Weeknum, and LeapYear for each day.
 * The data will be used in vmart demo database.
 *
 ******************/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

static void usage() {
    printf("Please type\n./vmart_genTime startYear endYear > Time.txt\nFor example\n./vmart_genTime 2003 2008 > Time.txt\n");
}

static int allDigits(char *str) {
    int i;
    for (i=0;i<strlen(str);i++) {
        if (str[i] < '0' || str[i] > '9')
            return 0;
    }
    return 1;
}

int main (int argc, char *argv[])
{
    int startYear = -1;
    int endYear = -1;

    if (argc != 3) {
        usage();
        exit(1);
    }

    startYear = atoi(argv[1]);
    endYear   = atoi(argv[2]);

    if (!allDigits(argv[1]) || startYear == 0) {
        printf("%s contains non-digit characters.\n", argv[1]);
        exit(1);
    }
    else if (!allDigits(argv[2]) || endYear == 0) {
        printf("%s contains non-digit characters.\n", argv[2]);
        exit(1);
    }
    else if (startYear > endYear) {
        printf("startYear %d is larger than endYear %d.\n", startYear, endYear);
        exit(1);
    }

    if (startYear <= 1900) {
        printf("Please enter year after 1900.\n");
        exit(1);
    }

    // The correct weeknum might be 53.
    // It is why we start one year earlier to get the correct weeknum.
    int weeknum = 52;

    int k;
    for (k=startYear-1;k<=endYear;k++) {
        struct tm start;
        start.tm_sec = 0;         /* seconds,  range 0 to 59          */
        start.tm_min = 0;         /* minutes, range 0 to 59           */
        start.tm_hour = 1;        /* hours, range 0 to 23             */
        start.tm_mday = 1;        /* day of the month, range 1 to 31  */
        start.tm_mon = 0;         /* month, range 0 to 11             */
        start. tm_year = k - 1900;/* The number of years since 1900   */

        time_t rawtime = mktime(&start);

        int yearDays = 365;
        int leapYear = 0;
        if ((k%4) == 0) {
            yearDays = 366;
            leapYear = 1;
        }

        int firstMonday = 1;

        int i;
        for (i=1;i<=yearDays;i++) {
            struct tm *info = localtime( &rawtime );
            if (info->tm_wday == 1) { // Monday
                if (firstMonday) {
                    weeknum = 1;
                    firstMonday = 0;
                }
                else
                    weeknum++;
            }
            if (k != startYear-1)
                printf("%02d/%02d/%d %d %d %d %d %d %d\n",
                       info->tm_mon+1, info->tm_mday,  1900 + info->tm_year,
                       info->tm_mday,  info->tm_mon+1, 1900 + info->tm_year,
                       info->tm_wday+1, weeknum, leapYear);
            rawtime += 86400;
        }
    }

    return(0);
}
