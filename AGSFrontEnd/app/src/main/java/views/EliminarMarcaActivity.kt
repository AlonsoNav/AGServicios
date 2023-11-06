package views

import android.app.Dialog
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import android.widget.TextView
import com.hytan.agserviciosv1.R

class EliminarMarcaActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_eliminar_marca)

        //Volver
        val volver = findViewById<Button>(R.id.buttonVolverEliminarMarca)
        volver.setOnClickListener{
            val volver = Intent(this,MenuGestionSistemaActivity::class.java)
            startActivity(volver)
            finish()
        }

        //Pop ups
        val dialog = Dialog(this)
        dialog.setContentView(R.layout.popup_confirmacion)
        dialog.setCancelable(true)
        dialog.getWindow()?.setBackgroundDrawableResource(android.R.color.transparent)
        dialog.getWindow()?.getAttributes()?.windowAnimations = R.style.CustomDialogAnimation

        val dialogInfo = Dialog(this)
        dialogInfo.setContentView(R.layout.popupinformativo)
        dialogInfo.setCancelable(true)
        dialogInfo.getWindow()?.setBackgroundDrawableResource(android.R.color.transparent)
        dialogInfo.getWindow()?.getAttributes()?.windowAnimations = R.style.CustomDialogAnimation

        //Eliminar
        val eliminar = findViewById<Button>(R.id.buttonEliminarMarca)
        eliminar.setOnClickListener{
            val yesButton = dialog.findViewById<Button>(R.id.buttonSiPUP)
            val noButton = dialog.findViewById<Button>(R.id.buttonNoPUP)
            val textViewPopupConfi = dialog.findViewById<TextView>(R.id.textViewPUPConfirm)
            val textViewPopup = dialogInfo.findViewById<TextView>(R.id.textViewPUP)

            textViewPopupConfi.text = "¿Realmente desea eliminar esta marca?"
            textViewPopup.text="Marca eliminada con éxito"

            yesButton.setOnClickListener {
                val listo = dialogInfo.findViewById<Button>(R.id.buttonListoPUP)
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