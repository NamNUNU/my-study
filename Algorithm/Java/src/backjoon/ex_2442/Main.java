package backjoon.ex_2442;

import java.util.Scanner;

/**
 * Created by homr on 2017. 5. 27..
 */
public class Main {
    public static void main(String[] args){
        Scanner sc = new Scanner(System.in);
        int num = sc.nextInt();

        for(int i = 1; i<=num; i++){
            for(int j = 0; j<num-i; j++){
                System.out.print(" ");
            }
            for(int j = 0; j<2*i-1; j++){
                System.out.print("*");
            }
            System.out.println();
        }
    }
}
