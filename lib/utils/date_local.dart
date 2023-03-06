
String formatHari(String day) {
  var hari = "";
  switch (day) {
    case 'Sunday':
      {
        hari = "Minggu";
      }
      break;
    case 'Monday':
      {
        hari = "Senin";
      }
      break;
    case 'Tuesday':
      {
        hari = "Selasa";
      }
      break;
    case 'Wednesday':
      {
        hari = "Rabu";
      }
      break;
    case 'Thursday':
      {
        hari = "Kamis";
      }
      break;
    case 'Friday':
      {
        hari = "Jumat";
      }
      break;
    case 'Saturday':
      {
        hari = "Sabtu";
      }
      break;
  }
  return hari;
}
