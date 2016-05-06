package com.issueTracker.web.servlet.mainServlet;

import com.issueTracker.Logger.Login;
import com.issueTracker.Register.Register;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by Reddy on 01.05.2016.
 */
public class LogServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.getWriter().write("Hmm... seems something goes wrong");
    }

    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String login = (String)req.getParameter("login");
        String pass = (String)req.getParameter("pass");
        try {
            Login user = new Login(login, pass);
            if(user.getID() == null) resp.getWriter().write("Wrong Login or Pass");
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
}
