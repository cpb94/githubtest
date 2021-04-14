$PBExportHeader$wi_mant_hisdivisas.srw
forward
global type wi_mant_hisdivisas from wi_mant_ventanas
end type
type st_2 from statictext within wi_mant_hisdivisas
end type
type em_fecha from u_em_campo within wi_mant_hisdivisas
end type
type st_nomdivisa from statictext within wi_mant_hisdivisas
end type
type dw_2 from datawindow within wi_mant_hisdivisas
end type
end forward

global type wi_mant_hisdivisas from wi_mant_ventanas
integer x = 0
integer y = 0
integer width = 2752
integer height = 1684
st_2 st_2
em_fecha em_fecha
st_nomdivisa st_nomdivisa
dw_2 dw_2
end type
global wi_mant_hisdivisas wi_mant_hisdivisas

type variables



end variables

on ue_recuperar;// Valores Para Funcion de bloqueo.

 titulo       =  This.title
 longitud     =  len(trim(string(em_fecha.text)))
 criterio[1]  =  trim(string(em_fecha.text))+ space(20-longitud)
 longitud     =  len(Trim(string(sle_valor.text)))
 criterio[2]  =  trim(String(sle_valor.text))+space(20-longitud)
 seleccion    =  criterio[1]+criterio[2]
 tabla        =  "hisdivisas"

 dw_2.Retrieve(sle_valor.text)
 dw_1.Retrieve(datetime(date(string(em_fecha.text))),sle_valor.Text)
 CALL Super::ue_recuperar






end on

on ue_inserta_fila;call wi_mant_ventanas::ue_inserta_fila;   dw_1.setitem(dw_1.getrow(),"fecha",datetime(date(string(em_fecha.text))))
   dw_1.setitem(dw_1.getrow(),"divisa",sle_valor.text)

end on

on ue_desactiva_claves;call wi_mant_ventanas::ue_desactiva_claves;em_fecha.Enabled  = FALSE
sle_valor.enabled = FALSE
end on

event open;call super::open;istr_parametros.s_titulo_ventana = "Mantenimiento de Divisas"
istr_parametros.s_listado        = "report_divisas"
This.title=istr_parametros.s_titulo_ventana


em_fecha.text=String(today())

dw_2.SetTransObject(SQLCA)
end event

on ue_activa_claves;call wi_mant_ventanas::ue_activa_claves;em_fecha.Enabled  = TRUE
sle_valor.enabled = TRUE
end on

on wi_mant_hisdivisas.create
int iCurrent
call super::create
this.st_2=create st_2
this.em_fecha=create em_fecha
this.st_nomdivisa=create st_nomdivisa
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.em_fecha
this.Control[iCurrent+3]=this.st_nomdivisa
this.Control[iCurrent+4]=this.dw_2
end on

on wi_mant_hisdivisas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_2)
destroy(this.em_fecha)
destroy(this.st_nomdivisa)
destroy(this.dw_2)
end on

type dw_1 from wi_mant_ventanas`dw_1 within wi_mant_hisdivisas
integer y = 300
integer width = 1701
integer height = 312
string dataobject = "dw_histdivisas"
end type

type st_1 from wi_mant_ventanas`st_1 within wi_mant_hisdivisas
integer x = 256
integer y = 56
integer width = 251
integer height = 88
string text = "Fecha"
end type

type cb_insertar from wi_mant_ventanas`cb_insertar within wi_mant_hisdivisas
integer x = 1810
integer y = 292
end type

type cb_borrar from wi_mant_ventanas`cb_borrar within wi_mant_hisdivisas
integer x = 1810
integer y = 408
end type

type sle_valor from wi_mant_ventanas`sle_valor within wi_mant_hisdivisas
integer x = 535
integer y = 184
integer width = 297
integer taborder = 20
boolean bringtotop = true
string mask = "XXXXXXXXXXXXXXXXXXXX"
end type

on sle_valor::modificado;call wi_mant_ventanas`sle_valor::modificado;st_nomdivisa.text=f_nombre_moneda(sle_valor.text)	
IF Trim(st_nomdivisa.text)="" THEN 
 IF Trim(sle_valor.text)<>"" Then  f_activar_campo(sle_valor)
 sle_valor.text=""
END IF


end on

event sle_valor::getfocus;call super::getfocus;ue_titulo     = "AYUDA SELECCION DE DIVISAS"
ue_datawindow = "dw_ayuda_divisas"
valor_empresa = FALSE

if em_fecha.text = "00/00/00" then
   f_activar_campo(em_fecha)
   return
end if

dw_2.Retrieve(sle_valor.text)

end event

type cb_salir from wi_mant_ventanas`cb_salir within wi_mant_hisdivisas
integer x = 1810
integer y = 524
end type

type control_tabulador from wi_mant_ventanas`control_tabulador within wi_mant_hisdivisas
end type

type st_2 from statictext within wi_mant_hisdivisas
integer x = 288
integer y = 188
integer width = 206
integer height = 88
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Divisa"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_fecha from u_em_campo within wi_mant_hisdivisas
integer x = 535
integer y = 56
integer width = 297
integer height = 88
integer taborder = 10
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

on getfocus;call u_em_campo::getfocus;sle_valor.text= ""

end on

type st_nomdivisa from statictext within wi_mant_hisdivisas
integer x = 864
integer y = 192
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

type dw_2 from datawindow within wi_mant_hisdivisas
integer x = 64
integer y = 636
integer width = 2546
integer height = 780
boolean bringtotop = true
string dataobject = "dw_list_hisdivisas"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

