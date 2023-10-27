package database
import okhttp3.MediaType.Companion.toMediaType
import okhttp3.OkHttpClient
import okhttp3.Request
import okhttp3.RequestBody.Companion.toRequestBody
import java.io.IOException
import android.util.Log
import kotlin.math.log

class userDatabase {

    fun postRequestToApi(username: String, password: String) {
        // Crea un cliente OkHttp
        val client = OkHttpClient()

        // Especifica la URL de tu API
        val apiUrl = "http://192.168.1.53:5000/login"  // Reemplaza con la URL real de tu API

        // Crea el cuerpo de la solicitud POST
        val json = """
        {
            "username": "$username",
            "password": "$password"
        }
    """.trimIndent()

        val requestBody = json.toRequestBody("application/json".toMediaType())

        // Crea una solicitud POST
        val request = Request.Builder()
            .url(apiUrl)
            .post(requestBody)
            .build()

        // Realiza la solicitud de forma asíncrona
        client.newCall(request).enqueue(object : okhttp3.Callback {
            override fun onFailure(call: okhttp3.Call, e: IOException) {
                // Manejo de errores en caso de falla de la solicitud
                e.printStackTrace()
            }

            override fun onResponse(call: okhttp3.Call, response: okhttp3.Response) {
                // Verifica si la solicitud fue exitosa (código de respuesta 200)
                if (response.isSuccessful) {
                    val responseBody = response.body?.string()

                    // Procesa la respuesta de la API (responseBody)
                    // Puedes analizar JSON u otro formato de respuesta aquí

                    // Nota: No olvides manejar la respuesta en un hilo UI si necesitas actualizar la interfaz de usuario.
                } else {
                    // Manejo de errores en caso de una respuesta no exitosa
                    println("Error en la solicitud: ${response.code}")
                }
                Log.d("TAG",response.body.toString())
            }
        })

    }
}