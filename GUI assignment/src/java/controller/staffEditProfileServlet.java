package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DB.StfAccDB;
import domain.StaffAccount;

@WebServlet("/staffEditProfileServlet")
public class staffEditProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private StfAccDB stfAccDB;

    public staffEditProfileServlet() {
        try {
            stfAccDB = new StfAccDB();
        } catch (Exception e) {
            throw new RuntimeException("Failed to initialize StfAccDB: " + e.getMessage(), e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String staffId = (String) session.getAttribute("userid");

        if (staffId != null) {
            String staffName = request.getParameter("staffName");
            String staffEmail = request.getParameter("staffEmail");
            String staffGender = request.getParameter("staffGender");
            String staffPassword = request.getParameter("staffPassword"); // Get the new password

            try {
                StaffAccount staffAccount = stfAccDB.getStaffById(staffId);

                if (staffAccount != null) {
                    staffAccount.setName(staffName);
                    staffAccount.setEmail(staffEmail);
                    if (staffGender != null && !staffGender.isEmpty()) {
                        staffAccount.setGender(staffGender.charAt(0));
                    }
                    if (staffPassword != null && !staffPassword.isEmpty()) {
                        staffAccount.setPsw(staffPassword);
                    }

                    stfAccDB.updateRecord(staffAccount);

                    session.setAttribute("name", staffName);
                    session.setAttribute("email", staffEmail);
                    session.setAttribute("gender", staffGender);

                    response.sendRedirect("staffProfile.jsp?updateSuccess=true");
                } else {
                    response.sendRedirect("staffProfile.jsp?error=staffnotfound");
                }
            } catch (Exception e) {
                System.err.println("Error updating staff information: " + e.getMessage());
                e.printStackTrace();
                response.sendRedirect("staffProfile.jsp?updateError=true");
            }
        } else {
            response.sendRedirect("adminlogin.jsp?sessionExpired=true");
        }
    }

    @Override
    public void destroy() {
        try {
            stfAccDB.shutDown();
        } catch (Exception e) {
            System.err.println("Error closing the connection in servlet destroy" + e.getMessage());
        }
    }
}