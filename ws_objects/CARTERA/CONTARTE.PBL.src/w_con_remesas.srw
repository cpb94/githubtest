$PBExportHeader$w_con_remesas.srw
$PBExportComments$€
forward
global type w_con_remesas from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_remesas
end type
type st_2 from statictext within w_con_remesas
end type
type st_nombre_banco from statictext within w_con_remesas
end type
type dw_listado from datawindow within w_con_remesas
end type
type st_remesa from statictext within w_con_remesas
end type
type em_remesa from u_em_campo within w_con_remesas
end type
type st_banco from statictext within w_con_remesas
end type
type em_banco from u_em_campo within w_con_remesas
end type
type em_anyo from u_em_campo within w_con_remesas
end type
type dw_detalle from datawindow within w_con_remesas
end type
type pb_2 from upb_imprimir within w_con_remesas
end type
type st_1 from statictext within w_con_remesas
end type
type st_3 from statictext within w_con_remesas
end type
end forward

global type w_con_remesas from w_int_con_empresa
integer width = 2962
integer height = 2272
pb_1 pb_1
st_2 st_2
st_nombre_banco st_nombre_banco
dw_listado dw_listado
st_remesa st_remesa
em_remesa em_remesa
st_banco st_banco
em_banco em_banco
em_anyo em_anyo
dw_detalle dw_detalle
pb_2 pb_2
st_1 st_1
st_3 st_3
end type
global w_con_remesas w_con_remesas

type variables
string filtro


end variables

on close;call w_int_con_empresa::close;dw_detalle.reset()
dw_listado.reset()
end on

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta de Remesas No Confirmadas"
This.title=istr_parametros.s_titulo_ventana

dw_detalle.SetTransObject(SQLCA)

em_anyo.text=string(year(today()))

dw_detalle.visible=false

 // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      em_anyo.text=istr_parametros.s_argumentos[2]
		em_banco.text=istr_parametros.s_argumentos[3]
		em_remesa.text=istr_parametros.s_argumentos[4]
      IF Trim(em_anyo.text)<>""and Not IsNull(em_anyo.text)and Trim(em_banco.text)<>"" and Not IsNull(em_banco.text)and Trim(em_remesa.text)<>"" and Not IsNull(em_remesa.text) Then
		   em_banco.triggerevent("modificado")
			em_remesa.triggerevent("modificado")
			em_remesa.triggerevent("tecla_tabulador")
		END IF 
	END IF

f_activar_campo(em_anyo)
end event

event ue_listar;dw_report  = dw_listado
dw_report.SetTransObject(SQLCA)
Datetime fecha
dw_report.Retrieve(codigo_empresa,dec(em_anyo.text),em_banco.text,dec(em_remesa.text))
CALL Super::ue_listar
end event

on w_con_remesas.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_2=create st_2
this.st_nombre_banco=create st_nombre_banco
this.dw_listado=create dw_listado
this.st_remesa=create st_remesa
this.em_remesa=create em_remesa
this.st_banco=create st_banco
this.em_banco=create em_banco
this.em_anyo=create em_anyo
this.dw_detalle=create dw_detalle
this.pb_2=create pb_2
this.st_1=create st_1
this.st_3=create st_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.st_nombre_banco
this.Control[iCurrent+4]=this.dw_listado
this.Control[iCurrent+5]=this.st_remesa
this.Control[iCurrent+6]=this.em_remesa
this.Control[iCurrent+7]=this.st_banco
this.Control[iCurrent+8]=this.em_banco
this.Control[iCurrent+9]=this.em_anyo
this.Control[iCurrent+10]=this.dw_detalle
this.Control[iCurrent+11]=this.pb_2
this.Control[iCurrent+12]=this.st_1
this.Control[iCurrent+13]=this.st_3
end on

on w_con_remesas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.st_2)
destroy(this.st_nombre_banco)
destroy(this.dw_listado)
destroy(this.st_remesa)
destroy(this.em_remesa)
destroy(this.st_banco)
destroy(this.em_banco)
destroy(this.em_anyo)
destroy(this.dw_detalle)
destroy(this.pb_2)
destroy(this.st_1)
destroy(this.st_3)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_remesas
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_remesas
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_remesas
integer x = 9
integer width = 2427
integer height = 88
end type

type pb_1 from upb_salir within w_con_remesas
integer x = 2734
integer width = 110
integer height = 96
integer taborder = 0
string picturename = "exit!"
end type

type st_2 from statictext within w_con_remesas
integer x = 110
integer y = 104
integer width = 174
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Año"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_nombre_banco from statictext within w_con_remesas
integer x = 1083
integer y = 116
integer width = 1202
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_listado from datawindow within w_con_remesas
boolean visible = false
integer width = 160
integer height = 252
integer taborder = 60
boolean bringtotop = true
string dataobject = "report_con_remesas"
boolean livescroll = true
end type

type st_remesa from statictext within w_con_remesas
integer x = 434
integer y = 224
integer width = 352
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Nº Remesa:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_remesa from u_em_campo within w_con_remesas
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 818
integer y = 220
integer width = 261
integer height = 76
integer taborder = 40
string facename = "Arial"
end type

event getfocus;call super::getfocus;if len(trim(string(em_banco.text)))=0 then 
	
	f_activar_campo(em_banco)
	
end if
 
ue_titulo     = "AYUDA SELECCION REMESAS"
ue_datawindow = "dw_ayuda_carremesas"
ue_filtro     = " banco = '" + em_banco.text + " ' and anyo_remesa = "+ em_anyo.text+ " "

        
end event

event modificado;call super::modificado;dec var_anyo,var_remesa
var_anyo=dec(em_anyo.text)
var_remesa=dec(em_remesa.text)
datetime var_f
string var_sit

select distinct carefectos.fremesa,carefectos.situacion
into :var_f,:var_sit
from carefectos
where carefectos.empresa=:codigo_empresa
and carefectos.anyo_remesa=:var_anyo
and carefectos.remesa=:var_remesa
and carefectos.banco=:em_banco.text
and carefectos.fremesa is not null;

if var_sit="1" then
	messagebox("Remesa no valida","La remesa nº "+trim(string(var_remesa))+" está confirmada")
	em_remesa.text=""
	f_activar_campo(em_remesa)
else
	st_1.text="Fecha: "+ STRING(date(var_f),"dd-mm-yy")
end if 



end event

event tecla_tabulador;call super::tecla_tabulador;if len(trim(string(em_anyo.text)))=0 then
	f_activar_campo(em_anyo)
	return
end if
if len(trim(string(em_banco.text)))=0 then
 	f_activar_campo(em_banco)
	return
end if
if len(trim(string(em_remesa.text)))=0 then
	f_activar_campo(em_remesa)
	return
end if

dw_detalle.Reset()
dw_detalle.Retrieve(codigo_empresa,dec(em_anyo.text),em_banco.text,dec(em_remesa.text))
dw_detalle.visible=true

end event

type st_banco from statictext within w_con_remesas
integer x = 544
integer y = 116
integer width = 242
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
string text = "Banco:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_banco from u_em_campo within w_con_remesas
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 818
integer y = 116
integer width = 261
integer height = 76
integer taborder = 20
string facename = "Arial"
end type

event getfocus;call super::getfocus;      ue_titulo     = "AYUDA SELECCION DE BANCOS"
		ue_datawindow = "dw_ayuda_carbancos"
		ue_filtro     = ""
  		
 
if len(trim(string(em_anyo.text)))=0 then 
	
	f_activar_campo(em_anyo)
	
end if
        
end event

event modificado;call super::modificado;st_nombre_banco.text = f_nombre_banco(codigo_empresa,em_banco.text)	

end event

type em_anyo from u_em_campo within w_con_remesas
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 59
integer y = 168
integer width = 261
integer height = 80
integer taborder = 10
string facename = "Arial"
end type

type dw_detalle from datawindow within w_con_remesas
integer x = 27
integer y = 336
integer width = 2825
integer height = 1672
integer taborder = 50
string dataobject = "dw_con_remesas"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type pb_2 from upb_imprimir within w_con_remesas
event clicked pbm_bnclicked
integer x = 2734
integer y = 232
integer taborder = 30
string picturename = "print!"
end type

event clicked;call super::clicked;Parent.triggerEvent("ue_listar")

end event

type st_1 from statictext within w_con_remesas
integer x = 1083
integer y = 220
integer width = 590
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 128
long backcolor = 67108864
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_3 from statictext within w_con_remesas
integer x = 1893
integer y = 264
integer width = 827
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Imprime informe con la remesa:"
alignment alignment = center!
boolean focusrectangle = false
end type

