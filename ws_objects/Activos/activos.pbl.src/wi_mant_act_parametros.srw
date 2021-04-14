$PBExportHeader$wi_mant_act_parametros.srw
forward
global type wi_mant_act_parametros from wi_mant_ventanas
end type
type gb_1 from groupbox within wi_mant_act_parametros
end type
end forward

global type wi_mant_act_parametros from wi_mant_ventanas
integer x = 0
integer y = 0
integer width = 1915
integer height = 936
boolean controlmenu = true
windowtype windowtype = main!
gb_1 gb_1
end type
global wi_mant_act_parametros wi_mant_act_parametros

type variables



end variables

forward prototypes
public subroutine f_borrar_espacios ()
end prototypes

public subroutine f_borrar_espacios ();// Eliminamos los espacios
int linea
 
linea = dw_1.getrow()  
IF LINEA > 0 THEN
	dw_1.setitem(linea,"dig1fam",trim(dw_1.getitemstring(linea,"dig1fam")))
	dw_1.setitem(linea,"dig2fam",trim(dw_1.getitemstring(linea,"dig2fam")))
	dw_1.setitem(linea,"dig3fam",trim(dw_1.getitemstring(linea,"dig3fam")))
	dw_1.setitem(linea,"digrfam",trim(dw_1.getitemstring(linea,"digrfam")))
end if

end subroutine

event open;call super::open;istr_parametros.s_titulo_ventana = "Significado de los dígitos de las Familias"
istr_parametros.s_listado        = "report_act_parametros"
This.title=istr_parametros.s_titulo_ventana

 // Si recibo el codigo lo visualizo

IF istr_parametros.i_nargumentos>1 THEN
     sle_valor.text=istr_parametros.s_argumentos[2]
     IF TRIM(sle_valor.text)<>"" AND Not IsNull(sle_valor.text) THEN
        	dw_1.Retrieve(sle_valor.text)
     END IF
END IF
end event

on ue_inserta_fila;call wi_mant_ventanas::ue_inserta_fila;  dw_1.setitem(dw_1.getrow(),"empresa",sle_valor.text)
end on

event ue_recuperar;// Valores Para Funcion de bloqueo
 titulo       = This.title
 longitud     =  len(trim(codigo_empresa))
 criterio[1]  =  trim(codigo_empresa)+ space(20-longitud)
 longitud     =  len(Trim(sle_valor.text))
 criterio[2]  =  trim(sle_valor.text)+space(20-longitud)
 seleccion    =  criterio[1]+criterio[2]
 tabla        = "act_parametros"
 dw_1.Retrieve(sle_valor.Text)
 CALL Super::ue_recuperar






end event

on wi_mant_act_parametros.create
int iCurrent
call super::create
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
end on

on wi_mant_act_parametros.destroy
call super::destroy
destroy(this.gb_1)
end on

type dw_1 from wi_mant_ventanas`dw_1 within wi_mant_act_parametros
integer x = 18
integer y = 204
integer width = 1838
integer height = 572
string dataobject = "dwact_parametros"
end type

event dw_1::clicked;call super::clicked;//f_borrar_espacios()
end event

type st_1 from wi_mant_ventanas`st_1 within wi_mant_act_parametros
integer x = 146
integer y = 76
integer height = 88
string text = "Empresa"
end type

type cb_insertar from wi_mant_ventanas`cb_insertar within wi_mant_act_parametros
integer x = 827
integer y = 76
integer width = 338
integer height = 80
end type

event cb_insertar::clicked;String var_descripcion

IF dw_1.GetRow() <> 0 Then
  	 if cb_insertar.enabled = TRUE THEN
		 dw_1.AcceptText()
		 var_descripcion  = trim(dw_1.GetItemString(dw_1.GetRow(),"dig1fam"))
		 If Trim(var_descripcion) = ""   or ISNULL(var_descripcion)Then
			dw_1.SetItem(dw_1.GetRow(),"dig1fam",".")
		 END IF
		
		 var_descripcion  = trim(dw_1.GetItemString(dw_1.GetRow(),"dig2fam"))
		 If Trim(var_descripcion) = ""   or ISNULL(var_descripcion)Then
			dw_1.SetItem(dw_1.GetRow(),"dig2fam",".")
		 END IF
		 
		 var_descripcion  = trim(dw_1.GetItemString(dw_1.GetRow(),"dig3fam"))
		 If Trim(var_descripcion) = ""   or ISNULL(var_descripcion)Then
			dw_1.SetItem(dw_1.GetRow(),"dig3fam",".")
		 END IF
		 
		 var_descripcion  = trim(dw_1.GetItemString(dw_1.GetRow(),"digrfam"))
		 If Trim(var_descripcion) = ""   or ISNULL(var_descripcion)Then
			dw_1.SetItem(dw_1.GetRow(),"digrfam",".")
		 END IF	
	end if
END IF
CALL super::Clicked
end event

type cb_borrar from wi_mant_ventanas`cb_borrar within wi_mant_act_parametros
integer x = 1166
integer y = 76
integer width = 338
integer height = 80
end type

type sle_valor from wi_mant_ventanas`sle_valor within wi_mant_act_parametros
integer x = 503
integer y = 76
boolean bringtotop = true
end type

event sle_valor::getfocus;call super::getfocus;ue_titulo         = "AYUDA SELECCION DE EMPRESAS"
ue_datawindow     = "dw_ayuda_empresas"
ue_filtro         = "" 
valor_empresa 		= FALSE
isle_campo        = This  
end event

type cb_salir from wi_mant_ventanas`cb_salir within wi_mant_act_parametros
integer x = 1504
integer y = 76
integer width = 338
integer height = 80
end type

type control_tabulador from wi_mant_ventanas`control_tabulador within wi_mant_act_parametros
end type

type gb_1 from groupbox within wi_mant_act_parametros
integer x = 814
integer y = 44
integer width = 1042
integer height = 124
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
end type

