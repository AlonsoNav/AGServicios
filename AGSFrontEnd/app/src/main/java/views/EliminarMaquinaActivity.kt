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
import controllers.DeleteMachineController
import controllers.DeleteTypeController

class EliminarMaquinaActivity : AppCompatActivity() {
    private val deleteMachineController = DeleteMachineController()
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_eliminar_maquina)

        val volverEM = findViewById<Button>(R.id.buttonVolverEliminarMaquina)
        val eliminar = findViewById<Button>(R.id.buttonEliminarMaquina)
        val editSerial = findViewById<EditText>(R.id.editSerialEliminarMaquina)

        val dialogConf = Dialog(this)
        dialogConf.setContentView(R.layout.popup_confirmacion)
        dialogConf.setCancelable(true)
        dialogConf.getWindow()?.setBackgroundDrawableResource(android.R.color.transparent)
        dialogConf.getWindow()?.getAttributes()?.windowAnimations = R.style.CustomDialogAnimation

        val dialogInfo = Dialog(this)
        dialogInfo.setContentView(R.layout.popupinformativo)
        dialogInfo.setCancelable(true)

        volverEM.setOnClickListener{
            val volverEm= Intent(this,MenuGestionSistemaActivity::class.java)
            startActivity(volverEm)
            finish()
        }

        eliminar.setOnClickListener{

            val yesButton = dialogConf.findViewById<Button>(R.id.buttonSiPUP)
            val noButton = dialogConf.findViewById<Button>(R.id.buttonNoPUP)
            val textViewPopupConfi = dialogConf.findViewById<TextView>(R.id.textViewPUPConfirm)
            val textViewPopup = dialogInfo.findViewById<TextView>(R.id.textViewPUP)

            textViewPopupConfi.text = "¿Realmente desea eliminar esta máquina?"

            yesButton.setOnClickListener {
                dialogConf.dismiss()
                val serial = editSerial.text.toString()
                val eliminar = deleteMachineController.deleteMachineAttempt(serial,this) { response ->
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