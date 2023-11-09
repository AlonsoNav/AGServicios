package controllers

import android.content.Context
import database.userDatabase

class AddMachineController {

    private val userDatabase= userDatabase()
    fun addMachineAttempt(brand: String, type: String, serial: String, model: String, context: Context,
                         callback: (okhttp3.Response) -> Unit){
        val endpoint ="add_machine"
        val json =  """
        {
            "brand": "$brand",
            "type": "$type",
            "serial": "$serial",
            "model": "$model"
        }
    """.trimIndent()
        val addMachineSuccessful = userDatabase.postRequestToApi(json,endpoint) { response ->
            callback(response)
        }
    }
}