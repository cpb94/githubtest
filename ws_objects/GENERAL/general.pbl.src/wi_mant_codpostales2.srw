$PBExportHeader$wi_mant_codpostales2.srw
$PBExportComments$Mantenimiento de codigos postales ( clave alfa_numerica).
forward
global type wi_mant_codpostales2 from wi_mant_ventanas
end type
type st_2 from statictext within wi_mant_codpostales2
end type
type em_pais from u_em_campo within wi_mant_codpostales2
end type
type st_nompais from statictext within wi_mant_codpostales2
end type
end forward

global type wi_mant_codpostales2 from wi_mant_ventanas
integer x = 0
integer y = 0
integer width = 2199
integer height = 1060
st_2 st_2
em_pais em_pais
st_nompais st_nompais
end type
global wi_mant_codpostales2 wi_mant_codpostales2

type variables



end variables

on open;call wi_mant_ventanas::open;istr_parametros.s_titulo_ventana = "Mantenimiento de Códigos Postales"
istr_parametros.s_listado        = "report_codpostales"
This.title=istr_parametros.s_titulo_ventana

tipo_mantenimiento = 'C'
end on

on ue_inserta_fila;call wi_mant_ventanas::ue_inserta_fila;dw_1.setitem(dw_1.getrow(),"pais",em_pais.text)
dw_1.setitem(dw_1.getrow(),"codpostal",sle_valor.text)

end on

event ue_buscar;
// Lanza la ventana de ayuda para Busquedas de codigos si tiene datawindow asignada

isle_campo = sle_valor

IF trim(istr_parametros.s_nom_datawindow)<> "" THEN
  IF Not IsNumber(isle_campo.Text) THEN
	   String ll_clave
		istr_parametros.s_criterio_busqueda = isle_campo.Text
           
		OpenWithParm(w_busquedas,istr_parametros)
		ll_clave = Message.StringParm		// Devuelve el valor que enuentra ...
		if TRIM(ll_clave)="" and TRIM(sle_valor.text)<>"" then
         Return
      END IF
   	
		isle_campo.text = ll_clave
      isle_campo.TriggerEvent(Modified!)	// Mostrara la descripcion
      f_activar_campo(isle_campo)
	END IF
END IF
end event

on ue_recuperar;// Valores Para Funcion de bloqueo.
 titulo       =  This.title
 longitud     =  len(trim(codigo_empresa))
 criterio[1]  =  trim(codigo_empresa)+ space(20-longitud)
 longitud     =  len(Trim(sle_valor.text))
 criterio[2]  =  trim(sle_valor.text)+space(20-longitud)
 seleccion    =  criterio[1]+criterio[2]
 tabla        = "codpostales"

 dw_1.Retrieve(em_pais.text,sle_valor.Text)
 CALL Super::ue_recuperar






end on

on ue_activa_claves;call wi_mant_ventanas::ue_activa_claves;em_pais.Enabled = TRUE
end on

on ue_desactiva_claves;call wi_mant_ventanas::ue_desactiva_claves;em_pais.Enabled = FALSE
end on

on wi_mant_codpostales2.create
int iCurrent
call super::create
this.st_2=create st_2
this.em_pais=create em_pais
this.st_nompais=create st_nompais
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.em_pais
this.Control[iCurrent+3]=this.st_nompais
end on

on wi_mant_codpostales2.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_2)
destroy(this.em_pais)
destroy(this.st_nompais)
end on

type dw_1 from wi_mant_ventanas`dw_1 within wi_mant_codpostales2
integer x = 37
integer y = 340
integer width = 1595
integer height = 488
string dataobject = "dw_codpostales"
end type

event dw_1::key; valor_empresa = TRUE	
 bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
   CASE "provincia"
		valor_empresa = FALSE
      bus_datawindow = "dw_ayuda_provincias"
      bus_filtro     = "pais = '"+GetItemString(This.GetRow(),"pais")+"'"
		bus_titulo = "VENTANA SELECCION DE PROVINCIAS"
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key


end event

event dw_1::rbuttondown; valor_empresa = TRUE	
 bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
   CASE "provincia"
		valor_empresa = FALSE
      bus_datawindow = "dw_ayuda_provincias"
      bus_filtro     = "pais = '"+GetItemString(This.GetRow(),"pais")+"' "
		bus_titulo = "VENTANA SELECCION DE PROVINCIAS"
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

event dw_1::clicked;call super::clicked;string ls_objeto
datawindow var_datawindow
str_parametros lstr_param

// Devuelve el objeto al que apunta seguido del tabulador (~t) y 
// el numero de fila en la Datawindow

ls_objeto = dw_1.GetObjectAtPointer()
ls_objeto = Left(ls_objeto, Pos(ls_objeto, "~t", 1) - 1)

lstr_param.s_argumentos[1]  = "wi_mant_codpostales"

CHOOSE CASE ls_objeto

CASE 'pb_provincia'
	valor_empresa = FALSE
   lstr_param.i_nargumentos    = 3
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"pais")
   lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"provincia")
   OpenWithParm(wi_mant_provincias,lstr_param)  
END CHOOSE

IF trim(em_pais.text)=""  Or trim(st_nompais.text)="" or Not IsNumber(em_pais.text) THEN 
	f_activar_campo(em_pais)
end if




end event

type st_1 from wi_mant_ventanas`st_1 within wi_mant_codpostales2
integer x = 101
integer y = 204
integer width = 343
integer height = 88
string text = "Cod.Postal:"
end type

type cb_insertar from wi_mant_ventanas`cb_insertar within wi_mant_codpostales2
integer x = 1673
integer y = 340
end type

type cb_borrar from wi_mant_ventanas`cb_borrar within wi_mant_codpostales2
integer x = 1673
integer y = 468
end type

type sle_valor from wi_mant_ventanas`sle_valor within wi_mant_codpostales2
integer x = 471
integer y = 204
integer width = 448
integer taborder = 20
boolean bringtotop = true
end type

event sle_valor::getfocus;call super::getfocus;valor_empresa = FALSE
ue_titulo 	   = "AYUDA SELECCION CODIGOS POSTALES"
ue_datawindow	= "dw_ayuda_codpostales"
ue_filtro 	   = "pais = '" + em_pais.text + "' "
isle_campo     = this

f_no_nulo(em_pais)
if Trim(em_pais.text)="" or trim(st_nompais.text)="" then f_activar_campo(em_pais)	


end event

type cb_salir from wi_mant_ventanas`cb_salir within wi_mant_codpostales2
integer x = 1673
integer y = 596
end type

type control_tabulador from wi_mant_ventanas`control_tabulador within wi_mant_codpostales2
integer taborder = 30
end type

type st_2 from statictext within wi_mant_codpostales2
integer x = 265
integer y = 76
integer width = 192
integer height = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Pais:"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_pais from u_em_campo within wi_mant_codpostales2
integer x = 466
integer y = 68
integer taborder = 10
end type

event getfocus;call super::getfocus;valor_empresa = FALSE
sle_valor.text= ""
dw_1.retrieve(em_pais.text,sle_valor.text)

ue_titulo     = "AYUDA SELECCION DE PAISES"
ue_datawindow = "dw_ayuda_paises"
ue_filtro     = ""
isle_campo    = This

IF istr_parametros.i_nargumentos>1 THEN
  	  em_pais.text=istr_parametros.s_argumentos[2]	
     f_no_nulo(em_pais)
     em_pais.TriggerEvent("modificado")
     sle_valor.text=istr_parametros.s_argumentos[3]
     f_no_nulo(sle_valor)
     sle_valor.TriggerEvent("modificado")
     istr_parametros.i_nargumentos=0
	  IF Trim(sle_valor.text)<>"" and Trim(em_pais.text)<>"" THEN
          Parent.TriggerEvent("ue_recuperar")
			 f_activar_campo(sle_valor)
          Return
     END IF
 END IF
end event

on modificado;call u_em_campo::modificado;st_nompais.text=f_nombre_pais(em_pais.text)	
IF Trim(st_nompais.text)="" THEN 
 IF Trim(em_pais.text)<>"" Then  f_activar_campo(em_pais)
 em_pais.text=""
END IF


end on

type st_nompais from statictext within wi_mant_codpostales2
integer x = 750
integer y = 80
integer width = 718
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

