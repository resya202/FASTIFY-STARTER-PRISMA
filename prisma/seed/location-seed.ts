// import { PrismaClient } from "@prisma/client";

// const prisma = new PrismaClient();

// async function main() {
//     const indonesiaProvinces = [
//         {
//             provinces: "Aceh",
//             city: ["Banda Aceh", "Sabang"],
//             district: ["Aceh Besar", "Bireuen"],
//             subDistrict: ["Ingin Jaya", "Peusangan"]
//         },
//         {
//             provinces: "Bali",
//             city: ["Denpasar", "Badung"],
//             district: ["Buleleng", "Karangasem"],
//             subDistrict: ["Sukasada", "Abang"]
//         },
//         {
//             provinces: "Banten",
//             city: ["Serang", "Tangerang"],
//             district: ["Pandeglang", "Lebak"],
//             subDistrict: ["Cikande", "Cisauk"]
//         },
//         {
//             provinces: "Bengkulu",
//             city: ["Bengkulu", "Rejang Lebong"],
//             district: ["Kepahiang", "Seluma"],
//             subDistrict: ["Ujan Mas", "Curup"]
//         },
//         {
//             provinces: "Gorontalo",
//             city: ["Gorontalo", "Boalemo"],
//             district: ["Gorontalo Utara", "Pohuwato"],
//             subDistrict: ["Kwandang", "Dulupi"]
//         },
//         {
//             provinces: "Jakarta",
//             city: ["Jakarta Pusat", "Jakarta Utara"],
//             district: ["Jakarta Barat", "Jakarta Selatan"],
//             subDistrict: ["Gambir", "Tanjung Priok"]
//         },
//         {
//             provinces: "Jambi",
//             city: ["Jambi", "Sungai Penuh"],
//             district: ["Muaro Jambi", "Tanjung Jabung Timur"],
//             subDistrict: ["Jambi Selatan", "Pamenang"]
//         },
//         {
//             provinces: "Jawa Barat",
//             city: ["Bandung", "Bekasi"],
//             district: ["Garut", "Cirebon"],
//             subDistrict: ["Cimahi", "Rancasari"]
//         },
//         {
//             provinces: "Jawa Tengah",
//             city: ["Semarang", "Surakarta"],
//             district: ["Magelang", "Temanggung"],
//             subDistrict: ["Gajahmungkur", "Kedungdowo"]
//         },
//         {
//             provinces: "Jawa Timur",
//             city: ["Surabaya", "Malang"],
//             district: ["Sidoarjo", "Banyuwangi"],
//             subDistrict: ["Wonocolo", "Genteng"]
//         },
//         {
//             provinces: "Kalimantan Barat",
//             city: ["Pontianak", "Singkawang"],
//             district: ["Sambas", "Ketapang"],
//             subDistrict: ["Kubu Raya", "Ngabang"]
//         },
//         {
//             provinces: "Kalimantan Selatan",
//             city: ["Banjarmasin", "Banjarbaru"],
//             district: ["Barito Kuala", "Tanah Laut"],
//             subDistrict: ["Banjarmasin Tengah", "Banjarmasin Selatan"]
//         },
//         {
//             provinces: "Kalimantan Tengah",
//             city: ["Palangkaraya", "Kotawaringin Barat"],
//             district: ["Kotawaringin Timur", "Barito Utara"],
//             subDistrict: ["Pahandut", "Banjarmasin"]
//         },
//         {
//             provinces: "Kalimantan Timur",
//             city: ["Samarinda", "Balikpapan"],
//             district: ["Kutai Kartanegara", "Paser"],
//             subDistrict: ["Samarinda Ilir", "Balikpapan Selatan"]
//         },
//         {
//             provinces: "Kalimantan Utara",
//             city: ["Tarakan", "Nunukan"],
//             district: ["Bulungan", "Malinau"],
//             subDistrict: ["Tarakan Tengah", "Nunukan Selatan"]
//         },
//         {
//             provinces: "Kepulauan Bangka Belitung",
//             city: ["Pangkal Pinang", "Belitung"],
//             district: ["Bangka", "Belitung Timur"],
//             subDistrict: ["Riau Silip", "Tanjung Pandan"]
//         },
//         {
//             provinces: "Kepulauan Riau",
//             city: ["Batam", "Tanjung Pinang"],
//             district: ["Karimun", "Bintan"],
//             subDistrict: ["Batu Aji", "Tanjung Uban"]
//         },
//         {
//             provinces: "Lampung",
//             city: ["Bandar Lampung", "Metro"],
//             district: ["Lampung Selatan", "Tanggamus"],
//             subDistrict: ["Kedaton", "Panjang"]
//         },
//         {
//             provinces: "Maluku",
//             city: ["Ambon", "Saumlaki"],
//             district: ["Maluku Tengah", "Buru"],
//             subDistrict: ["Baguala", "Leihitu"]
//         },
//         {
//             provinces: "Maluku Utara",
//             city: ["Ternate", "Tidore"],
//             district: ["Halmahera Utara", "Halmahera Selatan"],
//             subDistrict: ["Ternate Selatan", "Tidore Utara"]
//         },
//         {
//             provinces: "Nusa Tenggara Barat",
//             city: ["Mataram", "Bima"],
//             district: ["Lombok Barat", "Lombok Timur"],
//             subDistrict: ["Sekotong", "Sakra"]
//         },
//         {
//             provinces: "Nusa Tenggara Timur",
//             city: ["Kupang", "Ruteng"],
//             district: ["Manggarai", "Sikka"],
//             subDistrict: ["Alak", "Petrus Kafiar"]
//         },
//         {
//             provinces: "Papua",
//             city: ["Jayapura", "Merauke"],
//             district: ["Papua Selatan", "Papua Tengah"],
//             subDistrict: ["Jayapura Utara", "Merauke Selatan"]
//         },
//         {
//             provinces: "Papua Barat",
//             city: ["Manokwari", "Sorong"],
//             district: ["Fakfak", "Kaimana"],
//             subDistrict: ["Manokwari Selatan", "Sorong Selatan"]
//         },
//         {
//             provinces: "Riau",
//             city: ["Pekanbaru", "Dumai"],
//             district: ["Kampar", "Siak"],
//             subDistrict: ["Tenayan Raya", "Dumai Selatan"]
//         },
//         {
//             provinces: "Sulawesi Barat",
//             city: ["Mamuju", "Majene"],
//             district: ["Polewali Mandar", "Mamasa"],
//             subDistrict: ["Mamuju Utara", "Banjarmasin"]
//         },
//         {
//             provinces: "Sulawesi Tengah",
//             city: ["Palu", "Donggala"],
//             district: ["Sigi", "Morowali"],
//             subDistrict: ["Palu Utara", "Donggala Utara"]
//         },
//         {
//             provinces: "Sulawesi Tenggara",
//             city: ["Kendari", "Bau-Bau"],
//             district: ["Kolaka", "Buton"],
//             subDistrict: ["Mandonga", "Mowila"]
//         },
//         {
//             provinces: "Sulawesi Utara",
//             city: ["Manado", "Bitung"],
//             district: ["Minahasa", "Sangihe"],
//             subDistrict: ["Tondano", "Sangir"]
//         },
//         {
//             provinces: "Sumatera Barat",
//             city: ["Padang", "Bukittinggi"],
//             district: ["Agam", "Solok"],
//             subDistrict: ["Koto Tangah", "Payakumbuh"]
//         },
//         {
//             provinces: "Sumatera Selatan",
//             city: ["Palembang", "Lubuklinggau"],
//             district: ["Musi Banyuasin", "Ogan Komering Ilir"],
//             subDistrict: ["Kemuning", "Sukarami"]
//         },
//         {
//             provinces: "Sumatera Utara",
//             city: ["Medan", "Binjai"],
//             district: ["Deli Serdang", "Langkat"],
//             subDistrict: ["Medan Helvetia", "Binjai Selatan"]
//         },
//         {
//             provinces: "Yogyakarta",
//             city: ["Yogyakarta", "Sleman"],
//             district: ["Bantul", "Gunungkidul"],
//             subDistrict: ["Umbulharjo", "Wonosari"]
//         },
//     ];

//     console.log(indonesiaProvinces);


//     //   for (const action of actions) {
//     //     await prisma.userPointsAction.upsert({
//     //       where: { name: action.name },
//     //       update: {},
//     //       create: action,
//     //     });
//     //   }

//     console.log("Database initialized with point actions");
// }

// main()
//     .catch((e) => {
//         console.error(e);
//         process.exit(1);
//     })
//     .finally(async () => {
//         await prisma.$disconnect();
//     });
