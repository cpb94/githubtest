$PBExportHeader$w_facturas_ventas_fobs_manual.srw
forward
global type w_facturas_ventas_fobs_manual from w_int_con_empresa
end type
type pb_1 from upb_salir within w_facturas_ventas_fobs_manual
end type
type em_fdesde from u_em_campo within w_facturas_ventas_fobs_manual
end type
type st_1 from statictext within w_facturas_ventas_fobs_manual
end type
type uo_cliente from u_em_campo_2 within w_facturas_ventas_fobs_manual
end type
type dw_1 from u_datawindow_consultas within w_facturas_ventas_fobs_manual
end type
type cb_consultar from u_boton within w_facturas_ventas_fobs_manual
end type
type cb_cancelar from u_boton within w_facturas_ventas_fobs_manual
end type
type cb_procesar from u_boton within w_facturas_ventas_fobs_manual
end type
type gb_6 from groupbox within w_facturas_ventas_fobs_manual
end type
type gb_5 from groupbox within w_facturas_ventas_fobs_manual
end type
type gb_4 from groupbox within w_facturas_ventas_fobs_manual
end type
type gb_2 from groupbox within w_facturas_ventas_fobs_manual
end type
type gb_1 from groupbox within w_facturas_ventas_fobs_manual
end type
type st_2 from statictext within w_facturas_ventas_fobs_manual
end type
type gb_3 from groupbox within w_facturas_ventas_fobs_manual
end type
type st_importe from editmask within w_facturas_ventas_fobs_manual
end type
type st_importe_ant from editmask within w_facturas_ventas_fobs_manual
end type
type em_fletes from editmask within w_facturas_ventas_fobs_manual
end type
end forward

global type w_facturas_ventas_fobs_manual from w_int_con_empresa
integer width = 2473
integer height = 1780
pb_1 pb_1
em_fdesde em_fdesde
st_1 st_1
uo_cliente uo_cliente
dw_1 dw_1
cb_consultar cb_consultar
cb_cancelar cb_cancelar
cb_procesar cb_procesar
gb_6 gb_6
gb_5 gb_5
gb_4 gb_4
gb_2 gb_2
gb_1 gb_1
st_2 st_2
gb_3 gb_3
st_importe st_importe
st_importe_ant st_importe_ant
em_fletes em_fletes
end type
global w_facturas_ventas_fobs_manual w_facturas_ventas_fobs_manual

type variables
dec importe_fobs,importe_fletes
end variables

on w_facturas_ventas_fobs_manual.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.em_fdesde=create em_fdesde
this.st_1=create st_1
this.uo_cliente=create uo_cliente
this.dw_1=create dw_1
this.cb_consultar=create cb_consultar
this.cb_cancelar=create cb_cancelar
this.cb_procesar=create cb_procesar
this.gb_6=create gb_6
this.gb_5=create gb_5
this.gb_4=create gb_4
this.gb_2=create gb_2
this.gb_1=create gb_1
this.st_2=create st_2
this.gb_3=create gb_3
this.st_importe=create st_importe
this.st_importe_ant=create st_importe_ant
this.em_fletes=create em_fletes
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.em_fdesde
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.uo_cliente
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.cb_consultar
this.Control[iCurrent+7]=this.cb_cancelar
this.Control[iCurrent+8]=this.cb_procesar
this.Control[iCurrent+9]=this.gb_6
this.Control[iCurrent+10]=this.gb_5
this.Control[iCurrent+11]=this.gb_4
this.Control[iCurrent+12]=this.gb_2
this.Control[iCurrent+13]=this.gb_1
this.Control[iCurrent+14]=this.st_2
this.Control[iCurrent+15]=this.gb_3
this.Control[iCurrent+16]=this.st_importe
this.Control[iCurrent+17]=this.st_importe_ant
this.Control[iCurrent+18]=this.em_fletes
end on

on w_facturas_ventas_fobs_manual.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.em_fdesde)
destroy(this.st_1)
destroy(this.uo_cliente)
destroy(this.dw_1)
destroy(this.cb_consultar)
destroy(this.cb_cancelar)
destroy(this.cb_procesar)
destroy(this.gb_6)
destroy(this.gb_5)
destroy(this.gb_4)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.st_2)
destroy(this.gb_3)
destroy(this.st_importe)
destroy(this.st_importe_ant)
destroy(this.em_fletes)
end on

event open;call super::open;title="FOBS MANUAL"

dw_1.settransobject(sqlca)

em_fdesde.text=string(relativedate(today(),-30))

f_activar_campo(uo_cliente.em_campo)

importe_fletes=0
IF istr_parametros.i_nargumentos>1 THEN
	importe_fobs=dec(istr_parametros.s_argumentos[2])
	x=integer(istr_parametros.s_argumentos[3])
	y=integer(istr_parametros.s_argumentos[4])
else
	importe_fobs=0
END IF

st_importe.text=string(importe_fobs,f_mascara_moneda(f_moneda_empresa(codigo_empresa)))
em_fletes.text=string(importe_fletes,f_mascara_moneda(f_moneda_empresa(codigo_empresa)))
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_facturas_ventas_fobs_manual
integer taborder = 100
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_facturas_ventas_fobs_manual
end type

type st_empresa from w_int_con_empresa`st_empresa within w_facturas_ventas_fobs_manual
end type

type pb_1 from upb_salir within w_facturas_ventas_fobs_manual
integer x = 2267
integer y = 12
integer taborder = 0
boolean bringtotop = true
end type

type em_fdesde from u_em_campo within w_facturas_ventas_fobs_manual
integer x = 439
integer y = 152
integer width = 283
integer height = 80
integer taborder = 150
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "Ð"
end type

type st_1 from statictext within w_facturas_ventas_fobs_manual
integer x = 32
integer y = 164
integer width = 393
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "F.Fra. Desde:"
boolean focusrectangle = false
end type

type uo_cliente from u_em_campo_2 within w_facturas_ventas_fobs_manual
event destroy ( )
integer x = 983
integer y = 152
integer width = 1198
integer height = 80
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

event modificado;call super::modificado;uo_cliente.em_campo.text=f_nombre_cliente(codigo_empresa,"C",uo_cliente.em_codigo.text)
If Trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_campo.text=""
	uo_cliente.em_codigo.text=""
	Return
end if 


end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Clientes"
ue_datawindow ="dw_ayuda_clientes"
ue_filtro = ""
end event

type dw_1 from u_datawindow_consultas within w_facturas_ventas_fobs_manual
integer x = 23
integer y = 248
integer width = 1979
integer height = 1328
integer taborder = 0
boolean bringtotop = true
string dataobject = "dw_facturas_ventas_fobs"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event clicked;call super::clicked;integer cont
dec fletes,anyo,factura,fob,importe_fob,fletes_pagados,importe_fletes_pagados

if dwo.name='marcada' then
	importe_fletes=0
	importe_fob=0
	importe_fletes_pagados=0
	for cont=1 to rowcount()
		if (object.marcada[cont]='S' AND cont<>row)  or (object.marcada[cont]='N' and cont=row) then
			anyo=object.anyo[cont]
			factura=object.factura[cont]
			
			select sum(importe*cambio)
			into :fletes
			from venlifac
			where empresa=:codigo_empresa and
					anyo=:anyo and
					factura=:factura and
					tipolinea='5';
			
			if isnull(fletes) then 
				fletes=0
			end if
			
			importe_fletes=importe_fletes+fletes
			
			select sum(importe_fobs)
			into :fob
			from venlifac
			where empresa=:codigo_empresa and
					anyo=:anyo and
					factura=:factura;
					
			if isnull(fob) then fob=0
			
			importe_fob=importe_fob+fob
			
			select sum(importe_fletes)
			into :fletes_pagados
			from venlifac
			where empresa=:codigo_empresa and
					anyo=:anyo and
					factura=:factura;
					
			if isnull(fletes_pagados) then fletes_pagados=0
			
			importe_fletes_pagados=importe_fletes_pagados + fletes_pagados
		end if			
	next
	
	st_importe_ant.text=string(importe_fob,f_mascara_moneda(f_moneda_empresa(codigo_empresa)))
	if importe_fletes_pagados<>0 then
		em_fletes.text=string(importe_fletes_pagados,f_mascara_moneda(f_moneda_empresa(codigo_empresa)))	
	else
		em_fletes.text=string(importe_fletes,f_mascara_moneda(f_moneda_empresa(codigo_empresa)))			
	end if
END IF
end event

type cb_consultar from u_boton within w_facturas_ventas_fobs_manual
integer x = 2039
integer y = 732
integer width = 352
integer height = 104
integer taborder = 110
boolean bringtotop = true
string text = "Consultar"
end type

event clicked;if uo_cliente.em_codigo.text='' then
	f_mensaje("Atención","Debe seleccionar un cliente")
	f_activar_campo(uo_cliente.em_campo)
	return;
end if

dw_1.retrieve(codigo_empresa,uo_cliente.em_codigo.text,datetime(date(em_fdesde.text)))

end event

type cb_cancelar from u_boton within w_facturas_ventas_fobs_manual
integer x = 2039
integer y = 948
integer width = 352
integer height = 104
integer taborder = 130
boolean bringtotop = true
string text = "Cancelar"
end type

event clicked;close(parent)
end event

type cb_procesar from u_boton within w_facturas_ventas_fobs_manual
integer x = 2039
integer y = 840
integer width = 352
integer height = 104
integer taborder = 120
string text = "Procesar"
end type

event clicked;long cont,linea,cont2
dec peso,anyo,factura,peso_total=0,importe_linea,fletes,importe_linea_fletes
string sel
datastore ds
boolean bien=true

// Variables para el calculo del ajuste
dec total_fob=0,total_fletes=0
long max_linea=0,max_anyo=0,max_factura=0
dec importe_max_linea=0


importe_fobs=dec(st_importe.text)
fletes=dec(em_fletes.text)

importe_fobs=importe_fobs - fletes

for cont=1 to dw_1.rowcount()
	if dw_1.object.marcada[cont]='S' then
		
		anyo=dw_1.object.anyo[cont]
		factura=dw_1.object.factura[cont]
		
		select sum(peso)
		into :peso
		from venlifac
		where empresa=:codigo_empresa and
				anyo=:anyo and
				factura=:factura and
				clase<>'M' and articulo<>'';
				
		if isnull(peso) then peso=0
		
		peso_total=peso_total+peso
	end if
next

for cont=1 to dw_1.rowcount()
	if dw_1.object.marcada[cont]='S' then
		
		anyo=dw_1.object.anyo[cont]
		factura=dw_1.object.factura[cont]
		
		sel="select peso,linea_factura from venlifac "+&
			 "where empresa='"+codigo_empresa+"' and "+&
			 "anyo="+string(anyo,'####') +" and "+&
			 "factura="+string(factura,'########')+" and "+&
			 "clase<>'M' and articulo<>''"
				
		//ds=f_cargar_cursor(sel)
		f_cargar_cursor_nuevo(sel, ds)
		for cont2=1 to ds.rowcount()
			peso=ds.object.peso[cont2]
			linea=ds.object.linea_factura[cont2]
			if peso_total<>0 then
				importe_linea=(peso*importe_fobs)/ peso_total
				importe_linea_fletes=(peso*fletes)/ peso_total
			else
				importe_linea=0
				importe_linea_fletes=0
			end if
			
			importe_linea=dec(string(importe_linea,f_mascara_moneda(f_moneda_empresa(codigo_empresa))))			
			importe_linea_fletes=dec(string(importe_linea_fletes,f_mascara_moneda(f_moneda_empresa(codigo_empresa))))			
			
			total_fob=total_fob + importe_linea
			total_fletes=total_fletes + importe_linea_fletes
			
			if importe_linea>importe_max_linea then
				importe_max_linea=importe_linea
				max_linea=linea
				max_anyo=anyo
				max_factura=factura
			end if
			
			update venlifac
			set importe_fobs=:importe_linea,
				 importe_fletes=:importe_linea_fletes
			where empresa=:codigo_empresa and
					anyo=:anyo and
					factura=:factura and
					linea_factura=:linea;
					
			if sqlca.sqlcode<>0 then
				f_mensaje("Atención","Error al grabar importe Fobs."+char(13)+&
				"Anyo:"+string(anyo)+" Factura:"+string(factura)+" Linea:"+string(linea))
				bien=false
			end if
		next		
		destroy ds
	end if
next

if max_linea<>0 then
	if total_fob<>importe_fobs then
		update venlifac
		set importe_fobs = importe_fobs + (:importe_fobs - :total_fob)
		where empresa=:codigo_empresa and
				anyo=:max_anyo and
				factura=:max_factura and
				linea_factura=:max_linea;
		if sqlca.sqlcode<>0 then
			bien=false
		end if
	end if
	if total_fletes<>fletes then
		update venlifac
		set importe_fletes = importe_fletes + (:fletes - :total_fletes)
		where empresa=:codigo_empresa and
				anyo=:max_anyo and
				factura=:max_factura and
				linea_factura=:max_linea;
		if sqlca.sqlcode<>0 then
			bien=false
		end if				
	end if	
end if

if bien then
	f_mensaje("OK","Información almacenada correctamente")
	commit;
else
	f_mensaje("Atención","Hubo un error al modificar Fob")
	rollback;
end if

dw_1.reset()
uo_cliente.em_campo.text=''
uo_cliente.em_codigo.text=''
st_importe.text='0'
em_fletes.text='0'
st_importe_ant.text='0'
end event

type gb_6 from groupbox within w_facturas_ventas_fobs_manual
integer x = 2011
integer y = 396
integer width = 398
integer height = 140
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Importe ant."
end type

type gb_5 from groupbox within w_facturas_ventas_fobs_manual
integer x = 2011
integer y = 548
integer width = 393
integer height = 136
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fletes"
end type

type gb_4 from groupbox within w_facturas_ventas_fobs_manual
integer x = 2011
integer y = 248
integer width = 393
integer height = 140
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Importe"
end type

type gb_2 from groupbox within w_facturas_ventas_fobs_manual
integer x = 18
integer y = 116
integer width = 722
integer height = 124
integer taborder = 90
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_1 from groupbox within w_facturas_ventas_fobs_manual
integer x = 2025
integer y = 700
integer width = 375
integer height = 360
integer taborder = 140
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
end type

type st_2 from statictext within w_facturas_ventas_fobs_manual
integer x = 750
integer y = 160
integer width = 233
integer height = 68
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Cliente:"
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_3 from groupbox within w_facturas_ventas_fobs_manual
integer x = 736
integer y = 116
integer width = 1463
integer height = 124
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
end type

type st_importe from editmask within w_facturas_ventas_fobs_manual
integer x = 2021
integer y = 296
integer width = 370
integer height = 72
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "###,###,###"
end type

type st_importe_ant from editmask within w_facturas_ventas_fobs_manual
integer x = 2021
integer y = 444
integer width = 370
integer height = 72
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "###,###,###"
end type

type em_fletes from editmask within w_facturas_ventas_fobs_manual
integer x = 2021
integer y = 600
integer width = 370
integer height = 72
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "###,###,###"
end type

