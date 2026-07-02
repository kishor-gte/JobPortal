/**
 * 
 */

window.onload = function() {
    document.getElementById('searchForm').addEventListener('submit', function(e) {
        e.preventDefault();
        const keyword = document.getElementById('keyword').value;
        const location = document.getElementById('location').value;

        const searchParams = '?keyword=' + encodeURIComponent(keyword) + '&location=' + encodeURIComponent(location);

        fetch('/jobs/search' + searchParams)
            .then(response => response.text())
            .then(data => {
                document.getElementById('jobResults').innerHTML = data;
            })
            .catch(error => {
                console.error('Error fetching jobs:', error);
            });
    });
};
