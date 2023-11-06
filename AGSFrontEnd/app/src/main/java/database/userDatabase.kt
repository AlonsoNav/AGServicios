package database
import okhttp3.MediaType.Companion.toMediaType
import okhttp3.OkHttpClient
import okhttp3.Request
import okhttp3.RequestBody.Companion.toRequestBody
import java.io.IOException
import com.google.gson.Gson
import android.util.Log
import org.json.JSONObject
import kotlin.math.log

class userDatabase {

    fun postRequestToApi(username: String, password: String,callback: (okhttp3.Response) -> Unit){
        // Crea un cliente OkHttp
        val client = OkHttpClient()

        // Especifica la URL de tu API
        val apiUrl = "https://8c26-186-177-184-229.ngrok-free.app/login"  // Reemplaza con la URL real de tu API

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
                callback(response)
            }
        })

    }


}