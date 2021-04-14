$PBExportHeader$wi_mant_carforpagidiomas.srw
forward
global type wi_mant_carforpagidiomas from wi_mvent_con_empresa
end type
type st_nomforma from statictext within wi_mant_carforpagidiomas
end type
type em_forma from u_em_campo within wi_mant_carforpagidiomas
end type
type st_2 from statictext within wi_mant_carforpagidiomas
end type
type st_nomidioma from statictext within wi_mant_carforpagidiomas
end type
type dw_idiomas from datawindow within wi_mant_carforpagidiomas
end type
end forward

global type wi_mant_carforpagidiomas from wi_mvent_con_empresa
integer x = 0
integer y = 0
integer width = 2921
integer height = 1696
st_nomforma st_nomforma
em_forma em_forma
st_2 st_2
st_nomidioma st_nomidioma
dw_idiomas dw_idiomas
end type
global wi_mant_carforpagidiomas wi_mant_carforpagidiomas

type variables
	// Tipo Tercero

string ic_tipoter

end variables

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;
		// Activamos los campos clave añadidos


sle_valor.enabled   = FALSE
em_forma.enabled   = FALSE
dw_idiomas.enabled=FALSE


end on

on ue_inserta_fila;call wi_mvent_con_empresa::ue_inserta_fila;dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
dw_1.setitem(dw_1.getrow(),"codigo",em_forma.text)
dw_1.setitem(dw_1.getrow(),"idioma",sle_valor.text)






end on

event open;call super::open;
istr_parametros.s_titulo_ventana = "Mantenimiento de Formas de pago por idioma"
istr_parametros.s_listado        = "report_carforpagidiomas"

This.title=istr_parametros.s_titulo_ventana
dw_idiomas.SetTransObject(SQLCA)
end event

event ue_recuperar;// Valores Para Funcion de bloqueo
 titulo       =  This.title

 longitud     =  len(trim(codigo_empresa))
 criterio[1]  =  trim(codigo_empresa)+ space(20-longitud)

 longitud     =  len(Trim(em_forma.text))
 criterio[2]  =  trim(em_forma.text)+space(20-longitud)
 
 longitud     =  len(Trim(sle_valor.text))
 criterio[3]  =  trim(sle_valor.text)+space(20-longitud)

 seleccion    =  criterio[1]+criterio[2]+criterio[3]

 tabla        = "carforpagidiomas"

 dw_1.Retrieve(codigo_empresa,em_forma.text,sle_valor.text)

 CALL Super::ue_recuperar



end event

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;
		// Activamos los campos clave añadidos

sle_valor.enabled = TRUE
em_forma.enabled   = TRUE
dw_idiomas.enabled=TRUE

end on

on wi_mant_carforpagidiomas.create
int iCurrent
call super::create
this.st_nomforma=create st_nomforma
this.em_forma=create em_forma
this.st_2=create st_2
this.st_nomidioma=create st_nomidioma
this.dw_idiomas=create dw_idiomas
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_nomforma
this.Control[iCurrent+2]=this.em_forma
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.st_nomidioma
this.Control[iCurrent+5]=this.dw_idiomas
end on

on wi_mant_carforpagidiomas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_nomforma)
destroy(this.em_forma)
destroy(this.st_2)
destroy(this.st_nomidioma)
destroy(this.dw_idiomas)
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_carforpagidiomas
integer x = 55
integer y = 368
integer width = 2149
integer height = 356
string dataobject = "dw_carforpagidiomas"
end type

event dw_1::clicked;call super::clicked;string ls_objeto
datawindow var_datawindow
str_parametros lstr_param
// Devuelve el objeto al que apunta seguido del tabulador (~t) y 
// el numero de fila en la Datawindow

ls_objeto = dw_1.GetObjectAtPointer()
ls_objeto = Left(ls_objeto, Pos(ls_objeto, "~t", 1) - 1)

lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "wi_mant_distribuifores"

CHOOSE CASE ls_objeto

CASE 'pb_pais'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"pais")
   OpenWithParm(wi_mant_paises,lstr_param)  
CASE 'pb_provincia'
   lstr_param.i_nargumentos    = 3
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"pais")
   lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"provincia")
   OpenWithParm(wi_mant_provincias,lstr_param)  
CASE 'pb_codpostal'
   lstr_param.i_nargumentos    = 3
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"pais")
   lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"cod_postal")
   OpenWithParm(wi_mant_codpostales,lstr_param)  
CASE 'pb_idioma'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"idioma")
   OpenWithParm(wi_mant_idiomas,lstr_param)  
CASE 'pb_moneda'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"moneda")
   OpenWithParm(wi_mant_divisas,lstr_param)  
END CHOOSE



end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_carforpagidiomas
integer x = 41
integer y = 172
integer width = 315
integer height = 68
string text = "Cod. Pago"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_carforpagidiomas
integer x = 2254
integer y = 376
end type

on cb_insertar::clicked;iF cb_insertar.enabled =TRUE THEN 
	dw_1.AcceptText()
END IF

call super::clicked


end on

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_carforpagidiomas
integer x = 2254
integer y = 492
boolean cancel = true
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_carforpagidiomas
integer x = 379
integer y = 260
integer width = 343
integer taborder = 20
end type

on sle_valor::modificado;call wi_mvent_con_empresa`sle_valor::modificado;st_nomidioma.text=f_nombre_idioma(sle_valor.text)	
IF Trim(st_nomidioma.text)="" THEN 
 IF Trim(st_nomidioma.text)<>"" Then f_activar_campo(sle_valor)
 sle_valor.text=""
END IF


end on

event sle_valor::getfocus;call super::getfocus;valor_empresa = FALSE

if Trim(em_forma.text)="" or trim(st_nomforma.text)="" or IsNull(em_forma.text) &
    or IsNull(st_nomforma.text) then
        f_activar_campo(em_forma)	
        RETURN
end iF


ue_titulo     = "AYUDA SELECCION IDIOMAS"
ue_datawindow = "dw_ayuda_idiomas"
ue_filtro     = ""
isle_campo    = this
dw_idiomas.retrieve(codigo_empresa,em_forma.text)
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_carforpagidiomas
integer x = 2254
integer y = 608
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_carforpagidiomas
integer taborder = 30
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_carforpagidiomas
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_carforpagidiomas
integer width = 2679
end type

type st_nomforma from statictext within wi_mant_carforpagidiomas
integer x = 745
integer y = 164
integer width = 1230
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

type em_forma from u_em_campo within wi_mant_carforpagidiomas
integer x = 379
integer y = 160
integer width = 347
integer taborder = 10
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Courier"
end type

on modificado;call u_em_campo::modificado;st_nomforma.text=f_nombre_carforpag(codigo_empresa,em_forma.text)	
IF Trim(st_nomforma.text)="" THEN 
 IF Trim(st_nomforma.text)<>"" Then f_activar_campo(em_forma)
 em_forma.text=""
END IF
dw_idiomas.retrieve(codigo_empresa,em_forma.text)


end on

event getfocus;call super::getfocus;valor_empresa = TRUE
dw_1.reset()

ue_titulo     = "AYUDA SELECCION FORMAS DE PAGO"
ue_datawindow = "dw_ayuda_carforpag"
ue_filtro     = ""		
isle_campo    = this

IF istr_parametros.i_nargumentos>1 THEN
	  em_forma.text=istr_parametros.s_argumentos[2]
     This.TriggerEvent("modificado")
	  sle_valor.text=istr_parametros.s_argumentos[3]
	  sle_valor.TriggerEvent("modificado")
  	  istr_parametros.i_nargumentos=0
     IF TRIM(sle_valor.text)<>"" AND Not IsNull(sle_valor.text) THEN
			Parent.TriggerEvent("ue_recuperar")
			f_activar_campo(sle_valor)     
			Return
     END IF     
     f_activar_campo(sle_valor)     
END IF


end event

type st_2 from statictext within wi_mant_carforpagidiomas
integer x = 123
integer y = 256
integer width = 242
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Idioma"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_nomidioma from statictext within wi_mant_carforpagidiomas
integer x = 741
integer y = 272
integer width = 1230
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

type dw_idiomas from datawindow within wi_mant_carforpagidiomas
integer x = 50
integer y = 740
integer width = 2153
integer height = 636
boolean bringtotop = true
string dataobject = "dw_carforpagidiomas1"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;iF row =0 Then Return
IF cb_insertar.enabled=TRUE THEN Return

sle_valor.text  = dw_idiomas.GetItemString(Row,"idioma")
sle_valor.TriggerEvent("modificado")

Parent.TriggerEvent("ue_recuperar")
f_activar_campo(sle_valor)

end event

