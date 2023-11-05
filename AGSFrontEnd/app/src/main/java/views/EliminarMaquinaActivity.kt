package views

import android.app.Dialog
import android.content.Context
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.Gravity
import android.view.LayoutInflater
import android.view.ViewGroup
import android.widget.Button
import android.widget.EditText
import android.widget.PopupWindow
import android.widget.TextView
import com.hytan.agserviciosv1.R

class EliminarMaquinaActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_eliminar_maquina)

        val volverEM = findViewById<Button>(R.id.buttonVolverEliminarMaquina)
        val eliminar = findViewById<Button>(R.id.buttonEliminarMaquina)
        val editSerial = findViewById<EditText>(R.id.editSerialEliminarMaquina)

        val dialog = Dialog(this)
        dialog.setContentView(R.layout.popup_confirmacion)
        dialog.setCancelable(true)

        val dialogInfo = Dialog(this)
        dialogInfo.setContentView(R.layout.popupinformativo)
        dialogInfo.setCancelable(true)

        volverEM.setOnClickListener{
            val volverEm= Intent(this,MenuGestionSistemaActivity::class.java)
            startActivity(volverEm)
            finish()
        }

        eliminar.setOnClickListener{
            val serial = editSerial.text.toString()

            val yesButton = dialog.findViewById<Button>(R.id.buttonSiPU)
            val noButton = dialog.findViewById<Button>(R.id.buttonNoPU)
            val textViewPopupConfi = dialog.findViewById<TextView>(R.id.textViewPUPConfirm)
            val textViewPopup = dialogInfo.findViewById<TextView>(R.id.textViewPUP)

            textViewPopupConfi.text = "¿Realmente desea eliminar esa máquina?"
            textViewPopup.text="Máquina eliminada con éxito"

            yesButton.setOnClickListener {
                val listo = dialogInfo.findViewById<Button>(R.id.buttonListoPU)
                dialog.dismiss()
                listo.setOnClickListener {
                    dialogInfo.dismiss()
                }
                dialogInfo.show()

            }
            noButton.setOnClickListener {
                dialog.dismiss()
            }
            dialog.show()

    }
}
    }