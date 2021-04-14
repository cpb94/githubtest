$PBExportHeader$wi_mant_vencondentregaidioma.srw
$PBExportComments$Mant. Condiciones de entrega por idiomas.
forward
global type wi_mant_vencondentregaidioma from wi_mvent_con_empresa
end type
type st_nomforma from statictext within wi_mant_vencondentregaidioma
end type
type em_forma from u_em_campo within wi_mant_vencondentregaidioma
end type
type st_2 from statictext within wi_mant_vencondentregaidioma
end type
type st_nomidioma from statictext within wi_mant_vencondentregaidioma
end type
type dw_idiomas from datawindow within wi_mant_vencondentregaidioma
end type
type gb_1 from groupbox within wi_mant_vencondentregaidioma
end type
end forward

global type wi_mant_vencondentregaidioma from wi_mvent_con_empresa
integer x = 0
integer y = 0
integer width = 2811
integer height = 1660
st_nomforma st_nomforma
em_forma em_forma
st_2 st_2
st_nomidioma st_nomidioma
dw_idiomas dw_idiomas
gb_1 gb_1
end type
global wi_mant_vencondentregaidioma wi_mant_vencondentregaidioma

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

event ue_inserta_fila;call super::ue_inserta_fila;dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
dw_1.setitem(dw_1.getrow(),"codigo",em_forma.text)
dw_1.setitem(dw_1.getrow(),"idioma",sle_valor.text)






end event

event open;call super::open;
istr_parametros.s_titulo_ventana = "Mantenimiento Pies de factura por idiomas"
istr_parametros.s_listado        = ""

This.title=istr_parametros.s_titulo_ventana
dw_idiomas.SetTransObject(SQLCA)
end event

on ue_recuperar;// Valores Para Funcion de bloqueo
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



end on

event ue_activa_claves;call super::ue_activa_claves;
		// Activamos los campos clave añadidos

sle_valor.enabled  = TRUE
em_forma.enabled   = TRUE
dw_idiomas.enabled = TRUE

end event

on wi_mant_vencondentregaidioma.create
int iCurrent
call super::create
this.st_nomforma=create st_nomforma
this.em_forma=create em_forma
this.st_2=create st_2
this.st_nomidioma=create st_nomidioma
this.dw_idiomas=create dw_idiomas
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_nomforma
this.Control[iCurrent+2]=this.em_forma
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.st_nomidioma
this.Control[iCurrent+5]=this.dw_idiomas
this.Control[iCurrent+6]=this.gb_1
end on

on wi_mant_vencondentregaidioma.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_nomforma)
destroy(this.em_forma)
destroy(this.st_2)
destroy(this.st_nomidioma)
destroy(this.dw_idiomas)
destroy(this.gb_1)
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_vencondentregaidioma
integer x = 5
integer y = 368
integer width = 2720
integer height = 352
string dataobject = "dw_vencondentegaidiomas"
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

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_vencondentregaidioma
integer x = 155
integer y = 168
integer width = 279
integer height = 68
string text = "Código"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_vencondentregaidioma
integer x = 1673
integer y = 272
integer width = 343
integer height = 76
end type

on cb_insertar::clicked;iF cb_insertar.enabled =TRUE THEN 
	dw_1.AcceptText()
END IF

call super::clicked


end on

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_vencondentregaidioma
integer x = 2021
integer y = 272
integer width = 343
integer height = 76
boolean cancel = true
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_vencondentregaidioma
integer x = 453
integer y = 260
integer width = 343
integer taborder = 30
end type

on sle_valor::modificado;call wi_mvent_con_empresa`sle_valor::modificado;st_nomidioma.text=f_nombre_idioma(sle_valor.text)	
IF Trim(st_nomidioma.text)="" THEN 
 IF Trim(st_nomidioma.text)<>"" Then f_activar_campo(sle_valor)
 sle_valor.text=""
END IF


end on

on sle_valor::getfocus;call wi_mvent_con_empresa`sle_valor::getfocus;valor_empresa = FALSE
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
end on

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_vencondentregaidioma
integer x = 2368
integer y = 272
integer width = 343
integer height = 76
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_vencondentregaidioma
integer taborder = 40
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_vencondentregaidioma
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_vencondentregaidioma
integer width = 2679
end type

type st_nomforma from statictext within wi_mant_vencondentregaidioma
integer x = 818
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

type em_forma from u_em_campo within wi_mant_vencondentregaidioma
integer x = 453
integer y = 160
integer width = 347
integer taborder = 10
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Courier"
end type

event modificado;call super::modificado;st_nomforma.text=f_nombre_vencondentrega(codigo_empresa,em_forma.text)	

IF Trim(st_nomforma.text)="" THEN 
 IF Trim(st_nomforma.text)<>"" Then f_activar_campo(em_forma)
 em_forma.text=""
END IF

dw_idiomas.retrieve(codigo_empresa,em_forma.text)


end event

event getfocus;call super::getfocus;valor_empresa = TRUE
dw_1.reset()

ue_titulo     = "AYUDA SELECCION PIES DE FACTURA"
ue_datawindow = "dw_ayuda_condentrega"
ue_filtro     = ""		
isle_campo    = this

IF istr_parametros.i_nargumentos>1 THEN
	  em_forma.text=istr_parametros.s_argumentos[2]
     sle_valor.text=istr_parametros.s_argumentos[3]
	  istr_parametros.i_nargumentos=0

			  IF TRIM(sle_valor.text)<>"" AND Not IsNull(sle_valor.text) THEN
					This.TriggerEvent("modificado")
					sle_valor.TriggerEvent("modificado")
					Parent.TriggerEvent("ue_recuperar")
					f_activar_campo(sle_valor)     
					Return
				 else
			  		This.TriggerEvent("modificado")
					f_activar_campo(sle_valor)     
					Return
			  END IF     
   		
END IF


end event

type st_2 from statictext within wi_mant_vencondentregaidioma
integer x = 155
integer y = 268
integer width = 297
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

type st_nomidioma from statictext within wi_mant_vencondentregaidioma
integer x = 818
integer y = 264
integer width = 695
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

type dw_idiomas from datawindow within wi_mant_vencondentregaidioma
integer x = 18
integer y = 724
integer width = 2711
integer height = 696
boolean bringtotop = true
string dataobject = "dw_con_vencondentregaidioma1"
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

type gb_1 from groupbox within wi_mant_vencondentregaidioma
integer x = 1659
integer y = 236
integer width = 1065
integer height = 124
integer taborder = 11
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 128
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

