package Main;

import Logger.Logger;

public class Main {
    public static void main(String[] args) {
        Main mn = new Main();
        Logger lg = new Logger();

        try {
            lg.IdentifyUser("money", "honey");
        } catch (Exception e) {
            System.out.print("error was occurred");
        }
    }
}
