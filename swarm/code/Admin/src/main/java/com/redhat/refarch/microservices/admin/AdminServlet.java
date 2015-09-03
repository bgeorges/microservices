package com.redhat.refarch.microservices.admin;

import com.redhat.refarch.microservices.admin.model.Order;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @author Bruno Georges
 */

@WebServlet(name = "AdminServlet", urlPatterns = "/admin")
public class AdminServlet extends HttpServlet
{

    @PersistenceContext
    EntityManager em;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
      List<Order> orders = em.createNamedQuery("Order.findAll", Order.class).getResultList();
        PrintWriter writer = resp.getWriter();
        writer.write("<html><head></head><body>\n");
        writer.write("<h2>MSA Demo Admin Console</h2></br>\n\n");
        writer.write("Transactions:\n\n");
        writer.write("<table><tr><th>Id</th><th>Tx Number</th><th>Tx Date</th></tr>\n");
        for (Order order : orders) {
          writer.write("<tr><td>" + order.getId() + "</td><td>" + order.getTransactionNumber() + "</td><td>" + order.getTransactionDate() + "</td></tr>\n");
        }
        writer.write("</table></body></html>");
    }
}
