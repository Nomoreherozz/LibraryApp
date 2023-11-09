var myaudio = document.getElementById("bg_music").autoplay = true;


function playBgMusic() {
    var audio = document.getElementById("bg_music");
    audio.play();
}

function pauseBgMusic() {
    var audio = document.getElementById("bg_music");
    audio.pause();
}


//Filter the title in track_renting_books
function filterTitle() {
    // Declare variables
    var input, filter, table, tr, td, i, txtValue;
    input = document.getElementById("filter-title");
    filter = input.value.toUpperCase();
    table = document.getElementById("track-table");
    tr = table.getElementsByTagName("tr");

    // Loop through all table rows, and hide those who don't match the search query
    for (i = 0; i < tr.length; i++) {
        td = tr[i].getElementsByTagName("td")[0];
        if (td) {
            txtValue = td.textContent || td.innerText;
            if (txtValue.toUpperCase().indexOf(filter) > -1) {
                tr[i].style.display = "";
            } else {
                tr[i].style.display = "none";
            }
        }
    }
}

function filterISSN() {
    // Declare variables
    var input, filter, table, tr, td, i, txtValue;
    input = document.getElementById("filter-issn");
    filter = input.value.toUpperCase();
    table = document.getElementById("track-book-table");
    tr = table.getElementsByTagName("tr");

    // Loop through all table rows, and hide those who don't match the search query
    for (i = 0; i < tr.length; i++) {
        td = tr[i].getElementsByTagName("td")[1];
        if (td) {
            txtValue = td.textContent || td.innerText;
            if (txtValue.toUpperCase().indexOf(filter) > -1) {
                tr[i].style.display = "";
            } else {
                tr[i].style.display = "none";
            }
        }
    }
}



$(document).ready(function () {
    $('select').select2();
})

//Declare Variables
var search = [];
const btn = document.querySelector('#submit__button');

//Get the input and search
btn.addEventListener('click', (event) => {

    var catVal = $("#select_box_cat").val();
    var authorVal = $("#select_box_author").val();
    var pubyearVal = $("#select_box_pubyear").val();

    search.push(catVal, authorVal, pubyearVal)

    document.getElementById("demo").innerHTML = search;

    AddToFilterTest(catVal, authorVal, pubyearVal);

})

//Function to print out
function AddToFilterTest(catVal, authorVal, pubYearVal) {

    $.ajax({
        type: 'GET',
        url: 'Home/SetViewBag',
        data: { s1: catVal, s2: authorVal, s3: pubYearVal },
        success: function (myresult) {
            console.log(myresult);
            $("#content_body").html(myresult)
        },
        error: AjaxFailed

    });
}

function AjaxFailed(myresult) {
    alert("nice try, book Not Found");
    console.log(myresult.status + ' ' + myresult.statusText);
}