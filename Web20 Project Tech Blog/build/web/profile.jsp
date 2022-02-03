<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.entities.Categories"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.entities.Message"%>
<%@page import="com.tech.blog.entities.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="error_page.jsp" %>

<%
    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        response.sendRedirect("login_page.jsp");
    }
%>



<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

        <!--CSS-->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous"><link href="CSS/style.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
            .banner-background{
                clip-path: polygon(25% 0%, 100% 0%, 75% 100%, 0% 100%);
            }
        </style>
    </head>
    <body>

        <!--Navbar - start-->

        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container-fluid">
                <a class="navbar-brand" href="#"> <span class="fa fa-asterisk"></span> My Project</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item">
                            <a class="nav-link active" aria-current="page" href="index.jsp"> <span class="fa fa-institution"></span> Home</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#"> <span class="fa fa-address-book-o"></span> Contact</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#!" data-toggle="modal" data-target="#add-post-modal" > <span class="fa fa-asterisk"></span>Do Post</a>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                <span class="fa fa-gear"></span> Categories
                            </a>
                            <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                                <li><a class="dropdown-item" href="#">Programming Languages</a></li>
                                <li><a class="dropdown-item" href="#">Projects Implementation</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="#">Data Structures</a></li>
                            </ul>
                        </li>
                        </li>

                    </ul>

                    <ul class="navbar-nav mr-right">
                        <li class="nav-item">
                            <a class="nav-link" href="#!" data-toggle="modal" data-target="#profile-modal">
                                <span class="fa fa-user-circle"> <%= user.getName()%> </span> </a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link" href="LogoutServlet" tabindex="-1" aria-disabled="false">
                                <span class="fa fa-user-times">Sign Out</span> </a>
                        </li>
                    </ul>


                </div>
            </div>
        </nav>
        <!--Navbar - end-->

        <%
            Message msg = (Message) session.getAttribute("msg");
            if (msg != null) {
        %>

        <div class="alert <%= msg.getCssClass()%>" role="alert">
            <%= msg.getContent()%>
        </div>

        <% session.removeAttribute("msg");
            }
        %>

        <!--Main body of the page-->

        <main>
            <div class="container">
                <div class="row mt-4">
                    <!--First col-->
                    <div class="col-md-4">
                        <!--Categories-->
                        <div class="list-group">
                            <a href="#" class="list-group-item list-group-item-action active">All Posts</a>
                            <%
                                PostDao dao = new PostDao(ConnectionProvider.getCon());
                                ArrayList<Categories> list2 = dao.getCategories();

                                for (Categories cat : list2) {
                            %>

                            <a href="#" class="list-group-item list-group-item-action"> 
                                <%= cat.getName() %>
                            </a>

                            <%
                                }
                            %>
                        </div>

                    </div>

                    <!--Second col-->
                    <div class="col-md-8">
                        <!--Posts-->


                    </div>
                </div>
            </div>
        </main>

        <!--Profile modal-->
        <!-- Modal -->
        <div class="modal fade" id="profile-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header primary-bg text-center">
                        <h5 class="modal-title" id="exampleModalLabel"> My Project </h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="container text-center">
                            <img src="pics/<%= user.getProfile()%>" class="img-fluid" style="border-radius:50%; max-width: 150px" >
                            <br>
                            <h5 class="modal-title mt-3" id="exampleModalLabel"> <%= user.getName()%> </h5>

                            <!-- Details-->
                            <div id="profile-details">
                                <table class="table">
                                    <tbody>
                                        <tr>
                                            <th scope="row">ID :</th>
                                            <td><%= user.getId()%></td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Email :</th>
                                            <td><%= user.getEmail()%></td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Gender :</th>
                                            <td><%= user.getGender().toUpperCase()%></td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Status :</th>
                                            <td><%= user.getAbout()%></td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Registered Date :</th>
                                            <td><%= user.getDateTime()%></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>

                            <!--Profile Edit-->
                            <div id="profile-edit"  style="display: none">
                                <h3 class="mt-2">Please Edit Carefully</h3>

                                <form action="EditServlet" method="post" enctype="multipart/form-data">

                                    <table class="table">
                                        <tr>
                                            <td>ID: </td>
                                            <td><%= user.getId()%></td>
                                        </tr>
                                        <tr>
                                            <td>Gender: </td>
                                            <td><%= user.getGender().toUpperCase()%></td>
                                        </tr>
                                        <tr>
                                            <td>Name: </td>
                                            <td><input type="type" class="form-control" name="user_name" value="<%= user.getName()%>"/></td>
                                        </tr>
                                        <tr>
                                            <td>Email: </td>
                                            <td><input type="email" class="form-control" name="user_email" value="<%= user.getEmail()%>"/></td>
                                        </tr>
                                        <tr>
                                            <td>Password: </td>
                                            <td><input type="password" class="form-control" name="user_pass" value="<%= user.getPassword()%>"/></td>
                                        </tr>
                                        <tr>
                                            <td>About: </td>
                                            <td>
                                                <textarea rows="4" class="form-control" name="user_about">
                                                    <%= user.getAbout()%>
                                                </textarea>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>New Profile</td>
                                            <td>
                                                <input type="file" name="image" class="form-control" />
                                            </td>
                                        </tr>
                                    </table>

                                    <div class="container">
                                        <button type="submit" class="btn btn-outline-primary">Save
                                        </button>
                                    </div>

                                </form>

                            </div>

                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button id="edit-profile-button" type="button" class="btn btn-primary">Edit</button>
                    </div>
                </div>
            </div>
        </div>

        <!--End of Profile Modal-->


        <!--Add Post Modal-->

        <div class="modal fade" id="add-post-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Provide the Post Details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">

                        <form id="add-post-form" action="AddPostServlet" method="post">

                            <div class="form-group">
                                <select class="form-control" name="cid">
                                    <option selected disabled>---Select Category---</option>

                                    <%
                                        PostDao obj = new PostDao(ConnectionProvider.getCon());
                                        ArrayList<Categories> list = obj.getCategories();

                                        for (Categories c : list) {
                                    %>

                                    <option value="<%= c.getCid()%>"> <%= c.getName()%> </option>

                                    <%
                                        }
                                    %>

                                </select>
                            </div>

                            <div class="form-group">
                                <input type="text" placeholder="Enter your title" name="title" class="form-control"/>
                            </div>

                            <div class="form-group">
                                <textarea class="form-control" placeholder="Enter your content" name="content" style=" height:150px"></textarea>
                            </div>

                            <div class="form-group">
                                <textarea class="form-control" placeholder="Enter your program (if any)" name="code" style=" height:150px"></textarea>
                            </div>

                            <div class="form-group">
                                <label>Select your pic</label>
                                <br>
                                <input type="file" name="pic">                                
                            </div>

                            <div class="container text-center">
                                <button type="submit" class="btn btn-outline-primary">Post</button>
                            </div>


                        </form>

                    </div>
                </div>
            </div>
        </div>

        <!--End Of Post Modal-->

        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js" integrity="sha384-vFJXuSJphROIrBnz7yo7oB41mKfc8JzQZiCq4NCceLEaO4IHwicKwpJf9c9IpFgh" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js" integrity="sha384-alpBpkh1PFOepccYVYDB4do5UnbKysX5WZXm3XxPqe5iKTfUKjNkCk9SaVuEZflJ" crossorigin="anonymous"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        <script>
            $(document).ready(function () {
                let editStatus = false;

                $('#edit-profile-button').click(function () {

                    if (editStatus == false) {
                        $("#profile-details").hide()

                        $("#profile-edit").show();
                        editStatus = true;
                        $(this).text("Back")
                    } else {
                        $("#profile-details").show()

                        $("#profile-edit").hide()
                        editStatus = false;
                        $(this).text("Edit")
                    }

                })
            });

        </script>


        <!--Add post JS-->
        <script>
            $(document).ready(function (e) {
                // 
                $("#add-post-form").on("submit", function (event) {
                    // this code gets called when form is submitted....
                    event.preventDefault();
                    console.log("you have submitted...")
                    let form = new FormData(this);

                    // Now requesting to server
                    $.ajax({
                        url: "AddPostServlet",
                        type: "POST",
                        data: form,
                        success: function (data, textStatus, jqXHR) {
                            // success...
                            console.log(data)
                            if (data.trim() == 'posted') {
                                swal("Good job!", "Saved Successfully", "success");
                            } else {
                                swal("Error!", "Something went wrong, try again...", "success");
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            // error...
                            swal("Error!", "Something went wrong, try again...", "error");
                        },

                        processData: false,
                        contentType: false
                    })
                })
            })
        </script>

    </body>
</html>