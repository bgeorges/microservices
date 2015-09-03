package com.redhat.refarch.microservices.admin;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import com.redhat.refarch.microservices.admin.model.Item;

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
@WebServlet(name = "ItemServlet", urlPatterns = "/item")
public class ItemServlet extends HttpServlet {

    @PersistenceContext
    EntityManager em;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Item> items = em.createNamedQuery("Item.findAll", Item.class).getResultList();
        PrintWriter writer = resp.getWriter();

        writer.write("<html><head></head><body>\n");
        writer.write("Items:\n\n");
        writer.write("<table><tr><th>Id</th><th>Name</th></tr>\n");

        for (Item item : items) {
            writer.write("<tr><td>" + item.getId() + "</td><td>" + item.getName() + "</td></tr>\n");
        }

        writer.write("</body></html>");
    }
}
