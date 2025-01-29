const shadowCards = document.querySelectorAll(".dish-item.menu-card");
const popupModal = document.getElementById("popupModal");
const closeModal = document.getElementById("closeModal");
const dishSelect = document.getElementById("dishSelect");

shadowCards.forEach((card) => {
    card.addEventListener("click", () => {
      // Show the pop-up
      popupModal.style.display = "block"
      const dishId = card.getAttribute("data-dish-id");

      if (dishId) {
        dishSelect.value = dishId; // Set the dropdown value
      }
    });
  });

  // Hide the pop-up when clicking the close button
  closeModal.addEventListener("click", () => {
    popupModal.style.display = "none";
  });

  // Hide the pop-up when clicking outside the modal content
  popupModal.addEventListener("click", (e) => {
    if (e.target === popupModal) {
       popupModal.style.display = "none";
    }
  });