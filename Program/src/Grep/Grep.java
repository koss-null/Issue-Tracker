package Grep;

import java.util.Scanner;
import java.util.List;
import java.util.ArrayList;

public class Grep {
    private static boolean readRegExp(String regexp, String s) {
        int reg_i = 0;

        if(regexp.charAt(reg_i) == '[') {
            List<Character> permissibleChars = new ArrayList<Character>();
            byte mode = 0; //0 - normal, 1 - *, 2 - +
            reg_i++;
            while(regexp.charAt(reg_i) != ']') {
                if(reg_i + 1 == regexp.length()) return false;
                permissibleChars.add(regexp.charAt(reg_i));
                reg_i++;
            }
            if(reg_i + 1 != regexp.length()) {
                switch (regexp.charAt(reg_i + 1)) {
                    case '*':
                        mode = 1;
                        reg_i++;
                        break;
                    case '+':
                        mode = 2;
                        reg_i++;
                        break;
                }
            }

            int cnt = 0;
            if(mode > 0) {
                if(mode == 2) {
                    regexp = regexp.substring(0, reg_i) + "*" + regexp.substring(reg_i + 1);    //replacing '+' with '*'
                }

                if (permissibleChars.contains(s.charAt(0))) {
                    cnt++;
                    if (1 < s.length() && readRegExp(regexp.substring(reg_i+1), s.substring(1))) return true;
                    else if (1 < s.length() && readRegExp(regexp, s.substring(1))) return true;
                    else return false;
                } else if(mode == 1){
                    if (readRegExp(regexp.substring(reg_i+1), s.substring(0))) return true;
                    else return false;
                }
            }

            if(mode == 2 && cnt == 0) return false;
            else {
                if(!permissibleChars.contains(s.charAt(0))) return false;
            }
        }

        int i = 0;

        while(reg_i < regexp.length() && regexp.charAt(reg_i) != '*' && regexp.charAt(reg_i) != '+' && regexp.charAt(reg_i) != '[') {
            if(i == s.length()) break;
            if(regexp.charAt(reg_i) == s.charAt(i)) {
                reg_i++; i++;
            } else return false;
        }
        if(reg_i == regexp.length()) return true;
        else return (reg_i==0 && i == 0) ? false : readRegExp(regexp.substring(reg_i), s.substring(i));
    }

    public static void main(String[] args) {
        Scanner in = new Scanner(System.in);
        String word = in.nextLine();
        // * - any num of symbols, + - one or more symbols, [] - pair of symbols

        String s = "";
        while(!s.equals("q")) {
            s = in.nextLine();
            for(int i = 0; i < s.length(); i++) {
                if (readRegExp(word, s.substring(i))) {
                    System.out.println("OK");
                    break;
                }
            }
        }
    }
}
