print("Error retrieving data : $e");
      Get.snackbar(
        'Error',
        'Failed to retrieve data: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor:
            redColor, // Mengatur warna latar belakang menjadi merah
        colorText: whiteColor,
      );
      Get.offAll(NilaiujianView());