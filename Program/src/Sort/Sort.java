package Sort;

import java.util.Comparator;
import java.util.Scanner;
import java.util.Arrays;

public class Sort {
    public static void main(String[] args) {
        int wordNumInString = 1;
        /*try {
            wordNumInString = Integer.parseInt(args[0]);
        } catch (Exception e) {
            System.out.println("Started without parameters; Sorting for 1-st word");
            wordNumInString = 0;
        }*/

        final int fwordNumInString = wordNumInString;

        Scanner in = new Scanner(System.in);
        System.out.println("Enter the number of strings");
        int n = in.nextInt();
        in.nextLine();  //reading \n after nextInt()

        String[] toSort = new String[n];
        for (int i = 0; i < toSort.length; i++) {
            toSort[i] = in.nextLine();
            if (toSort[i] != "" && cntWords(toSort[i]) < wordNumInString) {
                System.out.println("I cant add this string, too few words, please try again");
            }
        }

        Arrays.sort(toSort, new Comparator<String>() {
            public int compare(String o1, String o2) {
                return getNthWord(o1, fwordNumInString).compareTo(getNthWord(o2, fwordNumInString));
            }
        });

        for(int i = 0; i < toSort.length; i++) {
            System.out.println(toSort[i]);
        }
    }

    private static int cntWords(String s) {
        int cnt = 0;
        for(int i = 0; i < s.length(); i++) {
            if(s.charAt(i) == ' ' && i != 0 ) {
                cnt++;
                while(i < s.length() && s.charAt(i) == ' ') i++;
            }
        }
        if(s.charAt(s.length()-1) != ' ') cnt++;
        return cnt;
    }

    private static String getNthWord(String s, int n) {
        int i = 0;
        int cnt = 0;
        while(cnt != n) {
            while(i < s.length() && s.charAt(i) == ' ') i++;
            while(i < s.length() && s.charAt(i) != ' ') i++;
            cnt++;
        }

        String ret = "";
        while(i < s.length() && s.charAt(i) == ' ') i++;
        while(i < s.length() && s.charAt(i) != ' ') {
            ret += s.charAt(i);
            i++;
        }
        return ret;
    }
}
