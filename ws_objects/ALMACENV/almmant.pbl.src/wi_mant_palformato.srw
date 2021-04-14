$PBExportHeader$wi_mant_palformato.srw
$PBExportComments$Mant. pallets por formatos.
forward
global type wi_mant_palformato from wi_mvent_con_empresa
end type
type st_almacen from statictext within wi_mant_palformato
end type
type st_nombre_formato from statictext within wi_mant_palformato
end type
type sle_formato from u_em_campo within wi_mant_palformato
end type
type st_pallet_nombre from statictext within wi_mant_palformato
end type
type dw_pallets_formatos from datawindow within wi_mant_palformato
end type
end forward

global type wi_mant_palformato from wi_mvent_con_empresa
integer height = 1592
st_almacen st_almacen
st_nombre_formato st_nombre_formato
sle_formato sle_formato
st_pallet_nombre st_pallet_nombre
dw_pallets_formatos dw_pallets_formatos
end type
global wi_mant_palformato wi_mant_palformato

type variables

end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();
dw_1.Retrieve(codigo_empresa,sle_formato.text,sle_valor.Text)

dw_pallets_formatos.Retrieve(codigo_empresa,sle_formato.text)

end subroutine

event open;call super::open;istr_parametros.s_titulo_ventana = "Mantenimiento de pallets por formato"
istr_parametros.s_listado        = "report_palformatos"
This.title=istr_parametros.s_titulo_ventana
dw_pallets_formatos.SetTransObject(SQLCA)

f_mascara_columna(dw_1,"alturas","###.0")

end event

on ue_inserta_fila;call wi_mvent_con_empresa::ue_inserta_fila;dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
dw_1.setitem(dw_1.getrow(),"formato",sle_formato.text)
dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)
end on

on ue_recuperar;// Valores Para Funcion de bloqueo
titulo        = This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_formato.text))
criterio[2]   =  trim(sle_formato.text)+space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[3]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]+criterio[3]
tabla         =  "palformato"



f_control()
CALL Super::ue_recuperar
end on

on wi_mant_palformato.create
int iCurrent
call super::create
this.st_almacen=create st_almacen
this.st_nombre_formato=create st_nombre_formato
this.sle_formato=create sle_formato
this.st_pallet_nombre=create st_pallet_nombre
this.dw_pallets_formatos=create dw_pallets_formatos
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_almacen
this.Control[iCurrent+2]=this.st_nombre_formato
this.Control[iCurrent+3]=this.sle_formato
this.Control[iCurrent+4]=this.st_pallet_nombre
this.Control[iCurrent+5]=this.dw_pallets_formatos
end on

on wi_mant_palformato.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_almacen)
destroy(this.st_nombre_formato)
destroy(this.sle_formato)
destroy(this.st_pallet_nombre)
destroy(this.dw_pallets_formatos)
end on

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;sle_formato.enabled=FALSE
end on

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;sle_formato.enabled=TRUE
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_palformato
integer x = 114
integer y = 440
string dataobject = "dw_pallets_formato"
end type

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_palformato
integer x = 261
integer y = 320
integer width = 343
integer height = 80
string text = "Pallet"
alignment alignment = right!
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_palformato
integer x = 1577
integer y = 440
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_palformato
integer x = 1577
integer y = 556
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_palformato
integer x = 635
integer y = 312
integer taborder = 20
end type

on sle_valor::modificado;call wi_mvent_con_empresa`sle_valor::modificado;st_pallet_nombre.text=f_nombre_pallet(codigo_empresa,sle_valor.text)
IF Trim(st_pallet_nombre.text)="" THEN 
 IF Trim(sle_valor.text)<>"" Then  f_activar_campo(sle_valor)
 sle_valor.text=""
END IF
end on

event sle_valor::getfocus;call super::getfocus;ue_titulo     = "AYUDA SELECCION DE PALLETS"
ue_datawindow = "dw_ayuda_pallets"
ue_filtro     = ""
isle_campo    = This

IF trim(sle_formato.text)= "" THEN
	f_activar_campo(sle_formato)
	REturn	 
End if	
f_control()
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_palformato
integer x = 1577
integer y = 676
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_palformato
integer taborder = 30
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_palformato
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_palformato
end type

type st_almacen from statictext within wi_mant_palformato
integer x = 261
integer y = 180
integer width = 343
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Formato"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_nombre_formato from statictext within wi_mant_palformato
integer x = 905
integer y = 172
integer width = 1179
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type sle_formato from u_em_campo within wi_mant_palformato
integer x = 635
integer y = 172
integer taborder = 10
end type

event getfocus;call super::getfocus;  ue_titulo     = "AYUDA SELECCION DE FORMATOS"
  ue_datawindow = "dw_ayuda_formatos"
  ue_filtro     = ""
  isle_campo    = This
  sle_valor.Text = ""
  
  f_control()
        
  IF istr_parametros.i_nargumentos>1 THEN
 	  sle_formato.text=istr_parametros.s_argumentos[2]	
     sle_formato.TriggerEvent("modificado")
     sle_valor.text=istr_parametros.s_argumentos[3]
     sle_valor.TriggerEvent("modificado")
     istr_parametros.i_nargumentos=0
	  IF Trim(sle_valor.text)<>"" and Trim(sle_formato.text)<>"" THEN
          Parent.TriggerEvent("ue_recuperar")
			 f_activar_campo(sle_valor)
			 Return
		else
			 f_activar_campo(sle_valor)
			 Return
     END IF
  END IF







end event

on modificado;call u_em_campo::modificado;st_nombre_formato.text=f_nombre_formato(codigo_empresa,sle_formato.text)
IF Trim(st_nombre_formato.text)="" THEN 
 IF Trim(sle_formato.text)<>"" Then  f_activar_campo(sle_formato)
 sle_formato.text=""
END IF
end on

type st_pallet_nombre from statictext within wi_mant_palformato
integer x = 905
integer y = 324
integer width = 1198
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type dw_pallets_formatos from datawindow within wi_mant_palformato
integer x = 210
integer y = 924
integer width = 1157
integer height = 428
boolean bringtotop = true
string dataobject = "dw_pallets_formato1"
boolean border = false
boolean livescroll = true
end type

event clicked;IF row =0 Then Return
IF cb_insertar.enabled=TRUE THEN Return

sle_valor.text  = This.GetItemString(Row,"codigo")
sle_valor.TriggerEvent("modificado")

Parent.TriggerEvent("ue_recuperar")
f_activar_campo(sle_valor)

end event

