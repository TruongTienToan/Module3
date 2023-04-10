<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Basic Tables | Zircos - Responsive Bootstrap 4 Admin Dashboard</title>
    <jsp:include page="/WEB-INF/layout/css_head.jsp"></jsp:include>

</head>

<body data-layout="horizontal">

<!-- Begin page -->
<div id="wrapper">

    <!-- Navigation Bar-->
    <jsp:include page="/WEB-INF/layout/topnav.jsp"></jsp:include>
    <!-- End Navigation Bar-->

    <!-- ============================================================== -->
    <!-- Start Page Content here -->
    <!-- ============================================================== -->

    <div class="content-page">
        <div class="content">

            <!-- Start Content-->
            <div class="container-fluid">

                <!-- start page title -->
                <div class="row">
                    <div class="col-12">
                        <div class="page-title-box">
                            <div class="page-title-right">
                                <ol class="breadcrumb m-0">
                                    <li class="breadcrumb-item"><a href="javascript: void(0);">Zircos</a></li>
                                    <li class="breadcrumb-item"><a href="javascript: void(0);">Tables</a></li>
                                    <li class="breadcrumb-item active">Basic Tables</li>
                                </ol>
                            </div>
                            <h4 class="page-title">Basic Tables</h4>
                        </div>
                    </div>
                </div>
                <!-- end page title -->

                <div class="row">
                    <form id="frmDelete" action="/customers?action=delete" method="post">
                        <input id="txtId" name="txtId" type="hidden"  />
                    </form>
                    <c:if test="${requestScope.message !=null}">
                        <script>
                            window.onload = function () {
                                Swal.fire({
                                    position: 'top-end',
                                    icon: 'success',
                                    title: 'Sửa thành công',
                                    showConfirmButton: false,
                                    timer: 1500
                                })
                            };
                        </script>
                    </c:if>
                    <table class="table table-dark m-0">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Address</th>
                            <th>Image</th>
                            <th>Customer type</th>
                            <th>Create At</th>
                            <td>Action</td>
                        </tr>
                        </thead>
                        <tbody>

                        <c:forEach items="${requestScope.customers}" var="c">
                            <tr>
                                <td>${c.getId()}</td>
                                <td>${c.getName()}</td>
                                <td>${c.getEmail()}</td>
                                <td>${c.getAddress()}</td>
                                <td>${c.getImage()}</td>
                                <td>
                                    <c:forEach items="${requestScope.customertypes}" var="ct">
                                        <c:if test="${ct.getId() == c.getCustomerType()}">
                                            ${ct.getName()}
                                        </c:if>
                                    </c:forEach>
                                </td>
                                <td>${c.getCreateAt()}</td>
                                <td>
                                    <a href="/customers?action=create">Add</a>
                                    <a href="/customers?action=edit&id=${c.getId()}">Edit</a>
                                    <a href="#" onclick="handleDelete(${c.getId()}, '${c.getName()}')">Delete</a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <!-- end col -->
                </div>
                <!-- end row -->

            </div>
            <!-- end container-fluid -->

        </div>
        <!-- end content -->


        <!-- Footer Start -->
        <jsp:include page="/WEB-INF/layout/footer.jsp"></jsp:include>
        <!-- end Footer -->

    </div>

    <!-- ============================================================== -->
    <!-- End Page content -->
    <!-- ============================================================== -->
    <script>
        function handleDelete(id, name){

            document.getElementById("txtId").value = id;
            Swal.fire({
                title: 'Bạn có muốn xóa hay không?',
                text: name,
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes!'
            }).then((result) => {
                if (result.isConfirmed) {
                    document.getElementById("frmDelete").submit();
                }
            })
        }
    </script>
</div>
<!-- END wrapper -->

<!-- Right Sidebar -->
<jsp:include page="/WEB-INF/layout/right_bar.jsp"></jsp:include>

<!-- Vendor js -->
<jsp:include page="/WEB-INF/layout/js_footer.jsp">
    <jsp:param name="page" value="customers"/>
</jsp:include>
>

</body>

</html>