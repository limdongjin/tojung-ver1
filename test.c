#include <stdio.h>
#include <stdlib.h>
#pragma warning(disable:4996)   // 이 줄을 추가하면 scanf() 함수를 사용할 수 있음.

int main()
{
   int score;
   char grade, result;

   printf("시험점수를 입력하세요 : ");
   scanf("%d", &score);

   if (90 < score && score <= 100)
      grade = "A";
   else if (80 < score && score <= 90)
      grade = "B";
   else if (70 < score && score <= 80)
      grade = "C";
   else if (60 < score && score <= 70)
      grade = "D";
   else
      grade = "F";

   if (grade == "A")
      result = "합격";
   else
      result = "불합격";


   printf("당신의 성적은 %c입니다\n", grade);
   printf("결과 : %c\n", result);

   system("pause");
   return 0;
}
