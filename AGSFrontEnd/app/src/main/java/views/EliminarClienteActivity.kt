package views

import android.app.Dialog
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import android.widget.EditText
import android.widget.TextView
import com.google.gson.JsonParser
import com.hytan.agserviciosv1.R
import controllers.DeleteClientController

class EliminarClienteActivity : AppCompatActivity() {
    private val deleteClientController = DeleteClientController()
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_eliminar_cliente)

        //Volver
        val volverEC = findViewById<Button>(R.id.buttonVolverEliminarCliente)
        volverEC.setOnClickListener{
            val volverEC = Intent(this, MenuGestionSistemaActivity::class.java)
            startActivity(volverEC)
            finish()
        }

        //Pop ups
        val dialogConf = Dialog(this)
        dialogConf.setContentView(R.layout.popup_confirmacion)
        dialogConf.setCancelable(true)
        dialogConf.getWindow()?.setBackgroundDrawableResource(android.R.color.transparent)
        dialogConf.getWindow()?.getAttributes()?.windowAnimations = R.style.CustomDialogAnimation

        //Eliminar
        val eliminar = findViewById<Button>(R.id.buttonEliminarCliente)
        val nameText = findViewById<EditText>(R.id.editNombreEmpresaEliminarCli)

        eliminar.setOnClickListener{
            val yesButton = dialogConf.findViewById<Button>(R.id.buttonSiPUP)
            val noButton = dialogConf.findViewById<Button>(R.id.buttonNoPUP)
            val textViewPopupConfi = dialogConf.findViewById<TextView>(R.id.textViewPUPConfirm)
            textViewPopupConfi.text = "¿Realmente desea eliminar este cliente?"

            yesButton.setOnClickListener {
                dialogConf.dismiss()
                val name = nameText.text.toString()
                val eliminar = deleteClientController.deleteClientAttempt(name,this) { response ->
                    val jsonString = response.body?.string()
                    runOnUiThread{
                        val dialog = Dialog(this)
                        dialog.getWindow()
                            ?.setBackgroundDrawableResource(android.R.color.transparent);
                        dialog.getWindow()?.getAttributes()?.windowAnimations =
                            R.style.CustomDialogAnimation
                        dialog.setContentView(R.layout.popupinformativo)
                        dialog.setCancelable(true)
                        val closeButton = dialog.findViewById<Button>(R.id.buttonListoPUP)
                        val textViewPopup = dialog.findViewById<TextView>(R.id.textViewPUP)
                        val jsonObject = JsonParser().parse(jsonString).asJsonObject
                        textViewPopup.text = jsonObject.get("message").asString
                        closeButton.setOnClickListener {
                            dialog.dismiss()
                        }
                        dialog.show()
                    }
                }
            }
            noButton.setOnClickListener {
                dialogConf.dismiss()
            }
            dialogConf.show()
        }
    }
}