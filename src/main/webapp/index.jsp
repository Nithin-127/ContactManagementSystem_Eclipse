<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.contacts.Contact" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Contact Management System</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; background: #f4f4f9; }
        .container { max-width: 650px; margin: auto; background: white; padding: 20px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        input, button { width: 100%; padding: 8px; margin: 6px 0; box-sizing: border-box; }
        button { background: #007BFF; color: white; border: none; border-radius: 4px; cursor: pointer; }
        button:hover { background: #0056b3; }
        table { width: 100%; margin-top: 20px; border-collapse: collapse; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; font-size: 14px; }
        th { background: #f2f2f2; }
        .delete-btn { background: #dc3545; width: auto; padding: 4px 8px; }
        .edit-btn { background: #ffc107; color: black; width: auto; padding: 4px 8px; }
        .edit-form { background: #fafafa; padding: 10px; margin-top: 5px; border: 1px dashed #ccc; display: none; }
    </style>
    <script>
        function toggleEdit(id) {
            var form = document.getElementById('edit-form-' + id);
            form.style.display = form.style.display === 'none' ? 'block' : 'none';
        }
    </script>
</head>
<body>
<div class="container">
    <h2>Contact Management System (No DB)</h2>
    
    <!-- Add Contact Form -->
    <form action="contacts" method="POST">
        <input type="hidden" name="action" value="add">
        <label>Name:</label>
        <input type="text" name="name" required>
        <label>Email:</label>
        <input type="email" name="email" required>
        <label>Phone:</label>
        <input type="text" name="phone" required>
        <button type="submit">Add Contact</button>
    </form>

    <hr>

    <h3>Saved Contacts</h3>
    <table>
        <tr>
            <th>Name</th>
            <th>Email</th>
            <th>Phone</th>
            <th>Actions</th>
        </tr>
        <% 
            List<Contact> list = (List<Contact>) request.getAttribute("contactList");
            if (list != null && !list.isEmpty()) {
                for (Contact c : list) {
        %>
        <tr>
            <td><%= c.getName() %></td>
            <td><%= c.getEmail() %></td>
            <td><%= c.getPhone() %></td>
            <td>
                <button type="button" class="edit-btn" onclick="toggleEdit(<%= c.getId() %>)">Edit</button>
                <form action="contacts" method="POST" style="display:inline; margin:0;">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="id" value="<%= c.getId() %>">
                    <button type="submit" class="delete-btn">Delete</button>
                </form>
            </td>
        </tr>
        <tr>
            <td colspan="4" style="padding:0;">
                <div id="edit-form-<%= c.getId() %>" class="edit-form">
                    <form action="contacts" method="POST">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="id" value="<%= c.getId() %>">
                        <input type="text" name="name" value="<%= c.getName() %>" required>
                        <input type="email" name="email" value="<%= c.getEmail() %>" required>
                        <input type="text" name="phone" value="<%= c.getPhone() %>" required>
                        <button type="submit">Save Changes</button>
                    </form>
                </div>
            </td>
        </tr>
        <% 
                }
            } else { 
        %>
        <tr>
            <td colspan="4" style="text-align:center;">No contacts found. Add one above!</td>
        </tr>
        <% } %>
    </table>
</div>
</body>
</html>