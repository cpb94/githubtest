$PBExportHeader$w_actualiza-desactualiza_fac.srw
forward
global type w_actualiza-desactualiza_fac from w_int_con_empresa
end type
type em_fechadesde from u_em_campo within w_actualiza-desactualiza_fac
end type
type gb_2 from groupbox within w_actualiza-desactualiza_fac
end type
type cb_continuar from commandbutton within w_actualiza-desactualiza_fac
end type
type dw_2 from datawindow within w_actualiza-desactualiza_fac
end type
type cb_2 from commandbutton within w_actualiza-desactualiza_fac
end type
type st_1 from statictext within w_actualiza-desactualiza_fac
end type
type dw_fac from datawindow within w_actualiza-desactualiza_fac
end type
type dw_1 from u_datawindow_consultas within w_actualiza-desactualiza_fac
end type
type em_serie from u_em_campo within w_actualiza-desactualiza_fac
end type
type st_nombre_serie from statictext within w_actualiza-desactualiza_fac
end type
type st_22 from statictext within w_actualiza-desactualiza_fac
end type
type em_fechahasta from u_em_campo within w_actualiza-desactualiza_fac
end type
type st_2 from statictext within w_actualiza-desactualiza_fac
end type
type dw_listado from datawindow within w_actualiza-desactualiza_fac
end type
type dw_proceso from datawindow within w_actualiza-desactualiza_fac
end type
type dw from datawindow within w_actualiza-desactualiza_fac
end type
type rb_actualizadas from radiobutton within w_actualiza-desactualiza_fac
end type
type gb_4 from groupbox within w_actualiza-desactualiza_fac
end type
type rb_desactualizadas from radiobutton within w_actualiza-desactualiza_fac
end type
type pb_2 from picturebutton within w_actualiza-desactualiza_fac
end type
type pb_1 from upb_salir within w_actualiza-desactualiza_fac
end type
end forward

global type w_actualiza-desactualiza_fac from w_int_con_empresa
integer x = 5
integer y = 268
integer width = 2907
integer height = 1652
em_fechadesde em_fechadesde
gb_2 gb_2
cb_continuar cb_continuar
dw_2 dw_2
cb_2 cb_2
st_1 st_1
dw_fac dw_fac
dw_1 dw_1
em_serie em_serie
st_nombre_serie st_nombre_serie
st_22 st_22
em_fechahasta em_fechahasta
st_2 st_2
dw_listado dw_listado
dw_proceso dw_proceso
dw dw
rb_actualizadas rb_actualizadas
gb_4 gb_4
rb_desactualizadas rb_desactualizadas
pb_2 pb_2
pb_1 pb_1
end type
global w_actualiza-desactualiza_fac w_actualiza-desactualiza_fac

type variables

String  var_situacion
end variables

on w_actualiza-desactualiza_fac.create
int iCurrent
call super::create
this.em_fechadesde=create em_fechadesde
this.gb_2=create gb_2
this.cb_continuar=create cb_continuar
this.dw_2=create dw_2
this.cb_2=create cb_2
this.st_1=create st_1
this.dw_fac=create dw_fac
this.dw_1=create dw_1
this.em_serie=create em_serie
this.st_nombre_serie=create st_nombre_serie
this.st_22=create st_22
this.em_fechahasta=create em_fechahasta
this.st_2=create st_2
this.dw_listado=create dw_listado
this.dw_proceso=create dw_proceso
this.dw=create dw
this.rb_actualizadas=create rb_actualizadas
this.gb_4=create gb_4
this.rb_desactualizadas=create rb_desactualizadas
this.pb_2=create pb_2
this.pb_1=create pb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_fechadesde
this.Control[iCurrent+2]=this.gb_2
this.Control[iCurrent+3]=this.cb_continuar
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.dw_fac
this.Control[iCurrent+8]=this.dw_1
this.Control[iCurrent+9]=this.em_serie
this.Control[iCurrent+10]=this.st_nombre_serie
this.Control[iCurrent+11]=this.st_22
this.Control[iCurrent+12]=this.em_fechahasta
this.Control[iCurrent+13]=this.st_2
this.Control[iCurrent+14]=this.dw_listado
this.Control[iCurrent+15]=this.dw_proceso
this.Control[iCurrent+16]=this.dw
this.Control[iCurrent+17]=this.rb_actualizadas
this.Control[iCurrent+18]=this.gb_4
this.Control[iCurrent+19]=this.rb_desactualizadas
this.Control[iCurrent+20]=this.pb_2
this.Control[iCurrent+21]=this.pb_1
end on

on w_actualiza-desactualiza_fac.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.em_fechadesde)
destroy(this.gb_2)
destroy(this.cb_continuar)
destroy(this.dw_2)
destroy(this.cb_2)
destroy(this.st_1)
destroy(this.dw_fac)
destroy(this.dw_1)
destroy(this.em_serie)
destroy(this.st_nombre_serie)
destroy(this.st_22)
destroy(this.em_fechahasta)
destroy(this.st_2)
destroy(this.dw_listado)
destroy(this.dw_proceso)
destroy(this.dw)
destroy(this.rb_actualizadas)
destroy(this.gb_4)
destroy(this.rb_desactualizadas)
destroy(this.pb_2)
destroy(this.pb_1)
end on

event open;call super::open;dw_1.SetTransObject(SQLCA)
dw_proceso.SetTransObject(SQLCA)
dw.SetTransObject(SQLCA)
dw_2.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)
Date  fecha

fecha = Today()

em_fechadesde.text =String(fecha,"dd-mm-yy")
em_fechahasta.text =String(fecha,"dd-mm-yy")
f_activar_campo(em_serie)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_actualiza-desactualiza_fac
integer x = 622
integer y = 620
integer taborder = 90
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_actualiza-desactualiza_fac
end type

type st_empresa from w_int_con_empresa`st_empresa within w_actualiza-desactualiza_fac
integer y = 12
end type

type em_fechadesde from u_em_campo within w_actualiza-desactualiza_fac
integer x = 27
integer y = 212
integer width = 288
integer taborder = 20
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type gb_2 from groupbox within w_actualiza-desactualiza_fac
integer x = 681
integer y = 184
integer width = 425
integer height = 124
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type cb_continuar from commandbutton within w_actualiza-desactualiza_fac
integer x = 699
integer y = 228
integer width = 389
integer height = 68
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Continuar"
end type

event clicked;
IF Trim(em_serie.text) = "" Then
	f_mensaje("Campo Obligarorio","Introduzca la serie")
	f_activar_campo(em_serie)
	Return
END IF
if rb_actualizadas.checked then
	var_situacion = "S"
else
	var_situacion = "N"
end if
dw_1.retrieve(codigo_empresa,em_serie.text,datetime(date(em_fechadesde.text)),datetime(date(em_fechahasta.text)),var_situacion)
if dw_1.rowcount() > 0 then
	pb_2.enabled = true
end if
end event

type dw_2 from datawindow within w_actualiza-desactualiza_fac
boolean visible = false
integer x = 649
integer y = 444
integer width = 1783
integer height = 864
integer taborder = 110
string dataobject = "dw_con_actualizacion_linfac"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type cb_2 from commandbutton within w_actualiza-desactualiza_fac
boolean visible = false
integer x = 677
integer y = 1220
integer width = 279
integer height = 72
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salir"
end type

event clicked;dw_2.visible=false
this.visible=false
end event

type st_1 from statictext within w_actualiza-desactualiza_fac
integer x = 27
integer y = 140
integer width = 635
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\BMP\Mano.cur"
long textcolor = 16711680
long backcolor = 79741120
string text = "Fecha Factura"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;dw_fac.SetTRansObject(SQLCA)
IF dw_fac.Retrieve(codigo_empresa) = 0 Then
	dw_fac.visible= FALSE
ELSE
	dw_fac.visible= TRUE
END IF

end event

type dw_fac from datawindow within w_actualiza-desactualiza_fac
boolean visible = false
integer x = 544
integer y = 148
integer width = 672
integer height = 408
integer taborder = 120
boolean bringtotop = true
string dataobject = "dw_con_actualizacion_fac2"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;IF f_objeto_datawindow(This) = "Salir" Then
	This.visible = FALSE
	Reset()
	f_activar_campo(em_fechadesde)
END IF
end event

event doubleclicked;iF row = 0 Then Return
em_fechadesde.text = String(Date(GetItemDateTime(row,"ffactura")),"dd-mm-yy")
visible = false
reset()
f_activar_campo(em_fechadesde)
end event

type dw_1 from u_datawindow_consultas within w_actualiza-desactualiza_fac
integer x = 14
integer y = 320
integer width = 2770
integer height = 1084
integer taborder = 0
string dataobject = "dw_con_actualiza-desactualiza_fac"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event clicked;call super::clicked;if isnull(dwo) then return
string nombre_objeto
long i
nombre_objeto=dwo.name
CHOOSE CASE nombre_objeto
	CASE "marcar_todo"
		string mt
		mt=dwo.border
		if mt='5' then
			dwo.border='6'
			for i=1 to this.rowcount()
				this.setitem(i,"libre","N")
			next
		else
			dwo.border='5'
			for i=1 to this.rowcount()
				this.setitem(i,"libre","S")
			next
		end if
END CHOOSE

end event

event ue_valores;ue_marca_linea = False
end event

event retrieveend;call super::retrieveend;this.Object.marcar_todo.border="5"
end event

event rbuttondown;if row=0 then return
dec anyo_fact,fact
anyo_fact=dw_1.getitemnumber(row,"anyo")
fact=dw_1.getitemnumber(row,"factura")

long n_lineas 
n_lineas=dw_2.retrieve(codigo_empresa,anyo_fact,fact)

if n_lineas=0 then
	messagebox("Lineas de Factura","Esta factura no tiene lineas")
	return
end if

dw_2.visible=true
cb_2.visible=true
end event

event doubleclicked;call super::doubleclicked;str_parametros lstr_param
IF rowCount() = 0 Then Return
IF Row <> 0 Then
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=String(This.GetItemNumber(Row,"anyo"))
  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"factura"))
  OpenWithParm(w_int_venfac,lstr_param) 
End If
end event

type em_serie from u_em_campo within w_actualiza-desactualiza_fac
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 850
integer y = 128
integer width = 142
integer height = 80
integer taborder = 10
boolean bringtotop = true
end type

event getfocus;call super::getfocus;      ue_titulo     = "AYUDA SELECCION DE SERIES"
		ue_datawindow = "dw_ayuda_venseries"
		ue_filtro     = ""
  


 
        
end event

event modificado;call super::modificado;st_nombre_serie.text=f_nombre_venseries(codigo_empresa,em_serie.text)
IF Trim(st_nombre_serie.text)="" THEN 
 IF Trim(em_serie.text)<>"" Then  f_activar_campo(em_serie)
 em_serie.text=""
END IF


end event

type st_nombre_serie from statictext within w_actualiza-desactualiza_fac
integer x = 997
integer y = 128
integer width = 603
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

type st_22 from statictext within w_actualiza-desactualiza_fac
integer x = 672
integer y = 136
integer width = 174
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Serie:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_fechahasta from u_em_campo within w_actualiza-desactualiza_fac
integer x = 366
integer y = 212
integer width = 293
integer taborder = 30
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_2 from statictext within w_actualiza-desactualiza_fac
integer x = 320
integer y = 208
integer width = 46
integer height = 76
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
string text = "-"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_listado from datawindow within w_actualiza-desactualiza_fac
boolean visible = false
integer x = 14
integer y = 4
integer width = 494
integer height = 96
integer taborder = 60
boolean bringtotop = true
string dataobject = "report_con_actualizacion_fac"
boolean livescroll = true
end type

type dw_proceso from datawindow within w_actualiza-desactualiza_fac
boolean visible = false
integer x = 2249
integer y = 20
integer width = 91
integer height = 76
integer taborder = 80
boolean bringtotop = true
string dataobject = "dw_con_actualizacion_fac3"
boolean livescroll = true
end type

type dw from datawindow within w_actualiza-desactualiza_fac
boolean visible = false
integer x = 2363
integer y = 20
integer width = 91
integer height = 76
integer taborder = 70
boolean bringtotop = true
string dataobject = "dw_con_actualizacion_fac4"
boolean livescroll = true
end type

type rb_actualizadas from radiobutton within w_actualiza-desactualiza_fac
integer x = 1623
integer y = 140
integer width = 933
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Actualizadas => No actualizadas"
boolean checked = true
end type

event clicked;pb_2.PictureName	 = "\bmp\candao_ab_e.bmp" 
pb_2.disabledname = "\bmp\candao_ab_d.bmp" 
dw_1.reset()
pb_2.enabled = false
cb_continuar.setfocus()
end event

type gb_4 from groupbox within w_actualiza-desactualiza_fac
integer x = 1605
integer y = 92
integer width = 960
integer height = 220
integer taborder = 130
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type rb_desactualizadas from radiobutton within w_actualiza-desactualiza_fac
integer x = 1623
integer y = 228
integer width = 933
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "No Actualizadas => Actualizadas"
end type

event clicked;pb_2.PictureName	 = "\bmp\candao_ce_e.bmp" 
pb_2.disabledname = "\bmp\candao_ce_d.bmp" 
dw_1.reset()
pb_2.enabled = false
cb_continuar.setfocus()
end event

type pb_2 from picturebutton within w_actualiza-desactualiza_fac
integer x = 2574
integer y = 128
integer width = 206
integer height = 188
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Tencer_PB12\Refresh_24x24.png"
string disabledname = "\bmp\candao_ab_d.bmp"
alignment htextalign = right!
end type

event clicked;Integer bien,i,v_anyo
long    v_factura
String marcada,v_empresa,nueva_situacion

IF MessageBox("Proceso de modificación","¿Continuar?",Question!,YesNo!) = 1 Then 
	this.enabled = false		
	
	if var_situacion = "S" then
		nueva_situacion = "N"
	else
		nueva_situacion = "S"
	end if
	
	FOR i = 1 To dw_1.RowCount()
	  marcada = dw_1.getitemstring(i,"libre")
	  IF marcada="S" THEN
	  		v_empresa     = dw_1.GetItemString(i,"empresa")
	  		v_anyo        = dw_1.GetItemNumber(i,"anyo")
	  		v_factura     = dw_1.GetItemNumber(i,"factura")
	  
			UPDATE venfac Set venfac.actualizada = :nueva_situacion
			WHERE  venfac.empresa  = :v_empresa
			AND    venfac.anyo     = :v_anyo  
			AND    venfac.factura  = :v_factura;
			IF SQLCA.SQLCODE <> 0 Then bien = 1
		end if
	NEXT

	IF bien = 1 Then
		f_mensaje("Error en proceso","la operacion no se actualiza")
		ROLLBACK;
	ELSE
		COMMIT;
	END IF
	cb_continuar.triggerevent(clicked!)
end if

end event

type pb_1 from upb_salir within w_actualiza-desactualiza_fac
integer x = 2642
integer y = 8
integer width = 110
integer height = 96
integer taborder = 0
boolean bringtotop = true
boolean originalsize = true
string picturename = "exit!"
end type

