package com.issueTracker.web.servlet.mainServlet;

import com.issueTracker.Register.Register;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Enumeration;

/**
 * Created by Reddy on 27.04.2016.
 */
public class RegServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.getWriter().write("Hmm... seems something goes wrong");
    }

    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String name = (String)req.getParameter("name");
        String login = (String)req.getParameter("login");
        String pass = (String)req.getParameter("pass");
        String about = (String)req.getParameter("about");
        try {
            Register.Registration(name, login, pass, about);
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
}
