package com.contacts;

import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

public class ContactManager {
    // Saves the text file securely inside your user home directory on your Mac
    private static final String FILE_PATH = System.getProperty("user.home") + "/contacts_data.txt";
    private static AtomicInteger idCounter = new AtomicInteger(1);

    public static List<Contact> getContacts() {
        List<Contact> contactList = new ArrayList<>();
        File file = new File(FILE_PATH);
        
        if (!file.exists()) {
            return contactList; 
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            int maxId = 0;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length >= 4) {
                    int id = Integer.parseInt(parts[0]);
                    String name = parts[1];
                    String email = parts[2];
                    String phone = parts[3];
                    contactList.add(new Contact(id, name, email, phone));
                    if (id > maxId) {
                        maxId = id;
                    }
                }
            }
            idCounter.set(maxId + 1);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return contactList;
    }

    public static void addContact(String name, String email, String phone) {
        List<Contact> contacts = getContacts();
        int newId = idCounter.getAndIncrement();
        contacts.add(new Contact(newId, name, email, phone));
        saveAllContacts(contacts);
    }

    public static void updateContact(int id, String name, String email, String phone) {
        List<Contact> contacts = getContacts();
        for (Contact c : contacts) {
            if (c.getId() == id) {
                c.setName(name);
                c.setEmail(email);
                c.setPhone(phone);
                break;
            }
        }
        saveAllContacts(contacts);
    }

    public static void deleteContact(int id) {
        List<Contact> contacts = getContacts();
        contacts.removeIf(c -> c.getId() == id);
        saveAllContacts(contacts);
    }

    private static void saveAllContacts(List<Contact> contacts) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (Contact c : contacts) {
                writer.write(c.getId() + "," + c.getName() + "," + c.getEmail() + "," + c.getPhone());
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}