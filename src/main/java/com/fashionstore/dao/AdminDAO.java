package com.fashionstore.dao;

import java.util.List;
import com.fashionstore.model.Admin;

public interface AdminDAO {

    boolean addAdmin(Admin admin);

    Admin loginAdmin(String email, String password);

    Admin getAdminById(int adminId);

    Admin getAdminByEmail(String email);

    boolean updateAdmin(Admin admin);

    boolean deleteAdmin(int adminId);

    List<Admin> getAllAdmins();
}