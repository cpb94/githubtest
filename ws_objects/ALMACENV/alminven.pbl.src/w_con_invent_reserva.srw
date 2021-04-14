$PBExportHeader$w_con_invent_reserva.srw
$PBExportComments$Consulta diferencias de inventarios con reservas.(pedidos).
forward
global type w_con_invent_reserva from w_int_con_empresa
end type
type st_2 from statictext within w_con_invent_reserva
end type
type dw_1 from datawindow within w_con_invent_reserva
end type
type pb_1 from upb_salir within w_con_invent_reserva
end type
type cb_2 from u_boton within w_con_invent_reserva
end type
type cb_3 from u_boton within w_con_invent_reserva
end type
type report_alminvent from datawindow within w_con_invent_reserva
end type
type dw_proceso from datawindow within w_con_invent_reserva
end type
type em_periodo from u_em_campo within w_con_invent_reserva
end type
type dw_inv from u_datawindow within w_con_invent_reserva
end type
end forward

global type w_con_invent_reserva from w_int_con_empresa
integer x = 14
integer y = 16
integer width = 2953
integer height = 2168
st_2 st_2
dw_1 dw_1
pb_1 pb_1
cb_2 cb_2
cb_3 cb_3
report_alminvent report_alminvent
dw_proceso dw_proceso
em_periodo em_periodo
dw_inv dw_inv
end type
global w_con_invent_reserva w_con_invent_reserva

type variables
String filtro

end variables

forward prototypes
public subroutine f_cargar (datawindow dt)
end prototypes

public subroutine f_cargar (datawindow dt);Integer contador,y1,r1,r,cont,ln
String referenciat,tipo_pallett,val,articulo,calidad,n_articulo,familia,formato,cri
Dec fisico,contable,tono,calibre,calibret,tonot
f_mascara_columna(dt,"t1",f_mascara_decimales(2))
f_mascara_columna(dt,"t2",f_mascara_decimales(2))
f_mascara_columna(dt,"t3",f_mascara_decimales(2))
f_mascara_columna(dt,"t4",f_mascara_decimales(2))
f_mascara_columna(dt,"t5",f_mascara_decimales(2))
f_mascara_columna(dt,"t6",f_mascara_decimales(2))
cont = 0
dt.Retrieve(codigo_empresa)
dt.SetRedraw(FALSE)
f_mensaje_proceso("Seleccionando...",1,100)
String referencia,tipo_pallet,sel
DataStore data 
Decimal{4} diferencia,total_difinv
sel = " Select * from alminvent " +&
		" Where empresa = '" + codigo_empresa + "'" +&
		" And   fecha_inv = '"+ String(Date(dw_1.GetItemDatetime(dw_1.Getrow(),"fecha_inv")),"dd/mm/yyyy")+"'" +&
		" And   (referencia <> referenciat or tipo_pallet <> tipo_pallett or existencias <> existenciast) " +&
		" ANd   activo = 'S' "

//data = f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, data)


contador = data.RowCOunt()
For y1 =1 To contador
f_mensaje_proceso("Grabando Diferencias...",y1,contador)
referencia        = data.GetItemString(y1,"referencia")
articulo        	= f_articulo_referencia(referencia)
calidad        	= f_calidad_referencia(referencia)
referenciat       = data.GetItemString(y1,"referenciat")
tipo_pallet       = data.GetItemString(y1,"tipo_pallet")
tipo_pallett      = data.GetItemString(y1,"tipo_pallett")
fisico            = data.GetItemNumber(y1,"existencias")
contable          = data.GetItemNumber(y1,"existenciast")
tono          		= Dec(f_tono_referencia(referencia))
calibre           = Dec(f_calibre_referencia(referencia))
tonot             = Dec(f_tono_referencia(referenciat))
calibret          = Dec(f_calibre_referencia(referenciat))
r1 = 1
IF referencia <> referenciat or tipo_pallet <> tipo_pallett Then r1 = 2
For r = 1 To r1
val = "S"
IF r1 = 2 and r = 1 Then 
	contable = 0
	fisico            = data.GetItemNumber(y1,"existencias")
END IF
IF r1 = 2 and r = 2 Then 
	fisico = 0
	contable          = data.GetItemNumber(y1,"existenciast")
	tipo_pallet = tipo_pallett
	tono        = tonot
	calibre     = calibret
	referencia  = referenciat
END IF
diferencia =  fisico - contable
//IF diferencia < 0 Then diferencia=diferencia * (-1)
 IF val = "S" Then 
		cri = " codigo_articulo ='"+articulo+"' and codigo_calidad ='"+calidad+"'"+&
			" and  tono   = "  + string(tono,"#0")+ &
			" and calibre = "  + string(calibre,"#0") +" and codigo_tipo_pallet ='"+ tipo_pallet +"'"


	ln =  dt.find(cri,1,dt.RowCount()) 
	IF ln = 0 Then
			cont = cont +1
		dt.InsertRow(cont)
		Select descripcion,familia,formato 
		Into :n_articulo,:familia,:formato 
		From  articulos
		Where  empresa = :codigo_empresa
		And    codigo  = :articulo;
		dt.SetItem(cont,"codigo_articulo",articulo)
		dt.SetItem(cont,"articulo",n_articulo)
		dt.SetItem(cont,"formato",f_nombre_formato_abr(codigo_empresa,formato))
		dt.SetItem(cont,"familia",f_nombre_familia(codigo_empresa,familia))
		dt.SetItem(cont,"codigo_calidad",calidad)
		dt.SetItem(cont,"calidad",f_nombre_calidad_abr(codigo_empresa,calidad))
		dt.SetItem(cont,"tono",tono)
		dt.SetItem(cont,"calibre",calibre)
		dt.SetItem(cont,"codigo_tipo_pallet",tipo_pallet)
		dt.SetItem(cont,"tipo_pallet",f_nombre_pallet_abr(codigo_empresa,tipo_pallet))
		fisico = f_existencias_alminvent(codigo_empresa,dw_1.GetItemDatetime(dw_1.Getrow(),"fecha_inv"),referencia,tipo_pallet)
		contable= f_existenciast_alminvent(codigo_empresa,dw_1.GetItemDatetime(dw_1.Getrow(),"fecha_inv"),referencia,tipo_pallet)
		diferencia = fisico - contable
		dt.SetItem(cont,"fisico",fisico)
		dt.SetItem(cont,"reservas",f_reservado_referencia_tipo_pallet(codigo_empresa,referencia,tipo_pallet))
		dt.SetItem(cont,"contable",contable)
		dt.SetItem(cont,"diferencia",diferencia)
//	ELSE
//		dt.SetItem(ln,"fisico",fisico + dt.GetItemNumber(ln,"fisico"))
//		dt.SetItem(ln,"contable",contable + dt.GetItemNumber(ln,"contable"))
//		dt.SetItem(ln,"diferencia",diferencia + dt.GetItemNumber(ln,"diferencia"))
	END IF
 END IF
Next
Next
dt.SetFilter("fisico < reservas")
dt.Filter()

dt.SetSort("articulo,calidad,tono,calibre,tipo_pallet")
dt.Sort()

dt.GroupCalc()
dt.SetRedraw(TRUE)

destroy data




      

end subroutine

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta diferencias inventarios(Reservas)"
This.title=istr_parametros.s_titulo_ventana
dw_1.settransobject(SQLCA)
dw_inv.settransobject(SQLCA)
dw_proceso.settransobject(SQLCA)
report_alminvent.settransobject(SQLCA)
dw_1.SetRowFocusIndicator(Hand!)		// Use hand for focus indicator

em_periodo.text=String(year(today()))
dw_1.Retrieve(codigo_empresa,Integer(em_periodo.text))

f_mascara_columna(dw_inv,"d1",f_mascara_decimales(2))
f_mascara_columna(dw_inv,"d2",f_mascara_decimales(2))
f_mascara_columna(dw_inv,"d3",f_mascara_decimales(2))

f_mascara_columna(report_alminvent,"d1",f_mascara_decimales(2))
f_mascara_columna(report_alminvent,"d2",f_mascara_decimales(2))
f_mascara_columna(report_alminvent,"d3",f_mascara_decimales(2))







end event

on w_con_invent_reserva.create
int iCurrent
call super::create
this.st_2=create st_2
this.dw_1=create dw_1
this.pb_1=create pb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.report_alminvent=create report_alminvent
this.dw_proceso=create dw_proceso
this.em_periodo=create em_periodo
this.dw_inv=create dw_inv
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.pb_1
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.cb_3
this.Control[iCurrent+6]=this.report_alminvent
this.Control[iCurrent+7]=this.dw_proceso
this.Control[iCurrent+8]=this.em_periodo
this.Control[iCurrent+9]=this.dw_inv
end on

on w_con_invent_reserva.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_2)
destroy(this.dw_1)
destroy(this.pb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.report_alminvent)
destroy(this.dw_proceso)
destroy(this.em_periodo)
destroy(this.dw_inv)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_invent_reserva
integer taborder = 20
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_invent_reserva
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_invent_reserva
integer y = 16
integer width = 2601
end type

type st_2 from statictext within w_con_invent_reserva
integer x = 5
integer y = 140
integer width = 274
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Periodo"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_con_invent_reserva
integer x = 590
integer y = 128
integer width = 777
integer height = 284
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_con_invent_dif1"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

on getfocus;This.BorderStyle=StyleLowered!
end on

on losefocus;This.BorderStyle=StyleRaised!
end on

type pb_1 from upb_salir within w_con_invent_reserva
integer x = 2725
integer y = 12
integer width = 119
integer height = 112
integer taborder = 0
end type

type cb_2 from u_boton within w_con_invent_reserva
integer x = 1408
integer y = 228
integer width = 389
integer height = 92
integer taborder = 50
string text = "&Consultar"
end type

event clicked;call super::clicked;f_cargar(dw_inv)		
end event

type cb_3 from u_boton within w_con_invent_reserva
integer x = 1408
integer y = 320
integer width = 389
integer height = 92
integer taborder = 60
string text = "&Imprimir"
end type

event clicked;call super::clicked;f_cargar(report_alminvent)
f_imprimir_datawindow(report_alminvent)      
end event

type report_alminvent from datawindow within w_con_invent_reserva
boolean visible = false
integer y = 280
integer width = 494
integer height = 164
integer taborder = 80
boolean bringtotop = true
string dataobject = "report_con_invent_reserva"
boolean livescroll = true
end type

type dw_proceso from datawindow within w_con_invent_reserva
boolean visible = false
integer x = 9
integer width = 494
integer height = 264
integer taborder = 70
boolean bringtotop = true
string dataobject = "dw_proceso_tipo_unidades"
boolean livescroll = true
end type

type em_periodo from u_em_campo within w_con_invent_reserva
integer x = 306
integer y = 128
integer width = 256
integer taborder = 30
maskdatatype maskdatatype = numericmask!
string mask = "####"
end type

on modified;call u_em_campo::modified;dw_1.Retrieve(codigo_empresa,Integer(em_periodo.text))
end on

type dw_inv from u_datawindow within w_con_invent_reserva
integer x = 5
integer y = 420
integer width = 2834
integer height = 1504
string dataobject = "dw_con_invent_reserva2"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;call super::doubleclicked;str_parametros lstr_param
Integer   linea
linea = row
IF linea = 0 Then   Return

lstr_param.s_argumentos[1] = "w_con_invent_reserva"
lstr_param.s_argumentos[2] = GetItemString(linea,"codigo_articulo")
lstr_param.i_nargumentos = 2

OpenWithParm(w_int_asignacion_stock,lstr_param) 

end event

event ue_valores;call super::ue_valores;ue_marca_linea = TRUE
end event

