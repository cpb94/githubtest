$PBExportHeader$u_em_campo_2.sru
$PBExportComments$Campo de introduccion con busquedas (en el campo de introduccion siempre mantiene el valor relacionado de la busqueda).
forward
global type u_em_campo_2 from UserObject
end type
type em_codigo from editmask within u_em_campo_2
end type
type em_campo from editmask within u_em_campo_2
end type
end forward

global type u_em_campo_2 from UserObject
int Width=2757
int Height=84
long BackColor=12632256
long PictureMaskColor=25166016
long TabTextColor=33554432
long TabBackColor=67108864
event modificado pbm_custom01
event busqueda pbm_custom02
event losefocus pbm_custom05
event key pbm_custom03
event getfocus pbm_custom04
event boton_derecha pbm_custom06
event tecla_enter pbm_custom07
event tecla_tabulador pbm_custom08
event tecla_f1 pbm_custom09
em_codigo em_codigo
em_campo em_campo
end type
global u_em_campo_2 u_em_campo_2

type variables
String ue_datawindow,ue_titulo,ue_filtro,ue_valor_anterior,ue_valor
EditMask ue_campo

end variables

event busqueda;str_parametros param
IF IsNull(ue_datawindow) or Trim(ue_datawindow)="" Then Return
   param.s_titulo_ventana   =  ue_titulo
   param.s_nom_datawindow   =  ue_datawindow
   param.s_filtro           =  ue_filtro
   param.b_empresa          =  valor_empresa
   This.em_codigo.text      =  Trim(ue_valor)
   This.em_campo.text       =  ""
   f_buscar(This.em_codigo,param)
   This.TriggerEvent("modificado")
	ue_valor_anterior = Trim(em_campo.text)
//	ue_campo.SetFocus()
	ue_campo.SelectText(1,Len(ue_campo.Text))
	

end event

event losefocus;IF Trim(ue_valor) = "" Then  
	This.em_codigo.text = "" 
ELSE
	This.em_codigo.text = Trim(ue_valor)
END IF
This.triggerEvent("modificado")

IF KeyDown(KeyTab!) Then
   IF	len(This.em_codigo.text) = 0 Then
	  This.TriggerEvent("tecla_tabulador")  
	END IF
END IF



end event

event getfocus;ue_campo.SelectText(1,Len(em_campo.Text))

end event

event boton_derecha;em_campo.text = ""
ue_valor = ""
This.TriggerEvent("busqueda")

end event

event tecla_enter;ue_campo.text = ""
ue_valor = ""
This.TriggerEvent("busqueda")

end event

event tecla_tabulador; IF len(ue_valor) <> 0  Then
   This.TriggerEvent("busqueda")
 END IF
 
 
 
 

end event

on u_em_campo_2.create
this.em_codigo=create em_codigo
this.em_campo=create em_campo
this.Control[]={this.em_codigo,&
this.em_campo}
end on

on u_em_campo_2.destroy
destroy(this.em_codigo)
destroy(this.em_campo)
end on

event constructor;ue_valor=""
ue_valor_anterior=""
This.Border = FALSE
em_campo.Border = TRUE
em_campo.BorderStyle = StyleLowered!
em_campo.width = This.width 
em_campo.height = This.height - 1

end event

type em_codigo from editmask within u_em_campo_2
int X=5
int Y=112
int Width=306
int Height=92
boolean Visible=false
BorderStyle BorderStyle=StyleLowered!
string Mask="XXXXXXXXXXXXXXXXXXXX"
MaskDataType MaskDataType=StringMask!
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Courier"
FontFamily FontFamily=Modern!
FontPitch FontPitch=Fixed!
end type

type em_campo from editmask within u_em_campo_2
event key pbm_keydown
event busqueda pbm_custom01
int Width=2743
int Height=84
int TabOrder=20
boolean Border=false
string Mask="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
MaskDataType MaskDataType=StringMask!
string DisplayData="Ä"
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Times New Roman"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Roman!
FontPitch FontPitch=Variable!
end type

event key;CHOOSE CASE Key
	CASE KeyEnter!
			ue_valor = This.text
         Parent.TriggerEvent("tecla_enter")
		CASE KeyF12!
			ue_valor = This.text
			This.TriggerEvent(rbuttonDown!)
	CASE KeyF1!
         Parent.TriggerEvent("tecla_f1")
	
   CASE KeyTab!
          //nada
END CHOOSE



end event

event getfocus;// Para solucionar que el primer input no abre ayuda 11-4-96
valor_empresa = TRUE  // Por defecto busquedas con empresa
This.BackColor= RGB(255,255,255)
IF ISNull(This.Text) or Trim(This.text)="" Then This.text = ""
ue_datawindow = ""
ue_valor_anterior=Trim(This.text)
ue_campo = This
Parent.triggerEvent("getfocus")

end event

event losefocus;This.BackColor= RGB(192,192,192)
ue_valor = This.text
IF ue_valor <> ue_valor_anterior Then
  Parent.TriggerEvent("losefocus")
END IF

end event

event rbuttondown;This.TriggerEvent(Getfocus!)
f_activar_campo(ue_campo)
Parent.TriggerEvent("boton_derecha")
end event

