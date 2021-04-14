$PBExportHeader$w_calculo_coste_articulo.srw
forward
global type w_calculo_coste_articulo from window
end type
type cb_3 from commandbutton within w_calculo_coste_articulo
end type
type dp_fecha_calculo from datepicker within w_calculo_coste_articulo
end type
type st_2 from statictext within w_calculo_coste_articulo
end type
type cbx_encajado from checkbox within w_calculo_coste_articulo
end type
type cb_2 from commandbutton within w_calculo_coste_articulo
end type
type st_regs from statictext within w_calculo_coste_articulo
end type
type st_1 from statictext within w_calculo_coste_articulo
end type
type cb_1 from commandbutton within w_calculo_coste_articulo
end type
type dp_fecha from datepicker within w_calculo_coste_articulo
end type
type st_proceso from statictext within w_calculo_coste_articulo
end type
type st_mensaje from statictext within w_calculo_coste_articulo
end type
type pb_salir from picturebutton within w_calculo_coste_articulo
end type
type pb_ejecutar from picturebutton within w_calculo_coste_articulo
end type
type uo_articulo from u_em_campo_2 within w_calculo_coste_articulo
end type
type cbx_mermas from checkbox within w_calculo_coste_articulo
end type
type cbx_fab from checkbox within w_calculo_coste_articulo
end type
type gb_1 from groupbox within w_calculo_coste_articulo
end type
type gb_5 from groupbox within w_calculo_coste_articulo
end type
type gb_2 from groupbox within w_calculo_coste_articulo
end type
type gb_3 from groupbox within w_calculo_coste_articulo
end type
end forward

global type w_calculo_coste_articulo from window
integer width = 3214
integer height = 2052
boolean titlebar = true
string title = "Cálculo Coste de un Artículo"
string menuname = "mi_menu_generico"
boolean controlmenu = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_3 cb_3
dp_fecha_calculo dp_fecha_calculo
st_2 st_2
cbx_encajado cbx_encajado
cb_2 cb_2
st_regs st_regs
st_1 st_1
cb_1 cb_1
dp_fecha dp_fecha
st_proceso st_proceso
st_mensaje st_mensaje
pb_salir pb_salir
pb_ejecutar pb_ejecutar
uo_articulo uo_articulo
cbx_mermas cbx_mermas
cbx_fab cbx_fab
gb_1 gb_1
gb_5 gb_5
gb_2 gb_2
gb_3 gb_3
end type
global w_calculo_coste_articulo w_calculo_coste_articulo

type variables
//Ventanas en el menú principal
Long id_ventana_activa
end variables

on w_calculo_coste_articulo.create
if this.MenuName = "mi_menu_generico" then this.MenuID = create mi_menu_generico
this.cb_3=create cb_3
this.dp_fecha_calculo=create dp_fecha_calculo
this.st_2=create st_2
this.cbx_encajado=create cbx_encajado
this.cb_2=create cb_2
this.st_regs=create st_regs
this.st_1=create st_1
this.cb_1=create cb_1
this.dp_fecha=create dp_fecha
this.st_proceso=create st_proceso
this.st_mensaje=create st_mensaje
this.pb_salir=create pb_salir
this.pb_ejecutar=create pb_ejecutar
this.uo_articulo=create uo_articulo
this.cbx_mermas=create cbx_mermas
this.cbx_fab=create cbx_fab
this.gb_1=create gb_1
this.gb_5=create gb_5
this.gb_2=create gb_2
this.gb_3=create gb_3
this.Control[]={this.cb_3,&
this.dp_fecha_calculo,&
this.st_2,&
this.cbx_encajado,&
this.cb_2,&
this.st_regs,&
this.st_1,&
this.cb_1,&
this.dp_fecha,&
this.st_proceso,&
this.st_mensaje,&
this.pb_salir,&
this.pb_ejecutar,&
this.uo_articulo,&
this.cbx_mermas,&
this.cbx_fab,&
this.gb_1,&
this.gb_5,&
this.gb_2,&
this.gb_3}
end on

on w_calculo_coste_articulo.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_3)
destroy(this.dp_fecha_calculo)
destroy(this.st_2)
destroy(this.cbx_encajado)
destroy(this.cb_2)
destroy(this.st_regs)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.dp_fecha)
destroy(this.st_proceso)
destroy(this.st_mensaje)
destroy(this.pb_salir)
destroy(this.pb_ejecutar)
destroy(this.uo_articulo)
destroy(this.cbx_mermas)
destroy(this.cbx_fab)
destroy(this.gb_1)
destroy(this.gb_5)
destroy(this.gb_2)
destroy(this.gb_3)
end on

event activate;//Ventanas en el menú principal
id_ventana_activa = f_menu_insertar_ventana(this)

end event

event close;f_menu_cerrar_ventana(this,id_ventana_activa)
end event

type cb_3 from commandbutton within w_calculo_coste_articulo
boolean visible = false
integer x = 2263
integer y = 644
integer width = 850
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Calculo Coste MP (€/m2)"
end type

event clicked;string sel
datastore data1
long total1, indice1
string formula

sel = "select distinct(proddetformula.formulacion) formula  "+&
				 "from proddetformula,prodformula "+&
				 "where proddetformula.empresa ='"+codigo_empresa+"' "  

total1 = f_cargar_cursor_transaccion(sqlca,data1,sel)

for indice1 = 1 to total1
	formula = data1.object.formula[indice1]				 
	
	f_recalculo_coste_mp_operacion (formula) 
	
	if sqlca.sqlcode <> 0 then
		rollback using SQLCA;
		messagebox("Recálculo de costes fórmulas","Error: "+sqlca.sqlerrtext)
	else
		commit using SQLCA;
	end if
	f_mensaje_proceso ("Recalculo Fórmula ", indice1 , total1)	
next	


end event

type dp_fecha_calculo from datepicker within w_calculo_coste_articulo
integer x = 2533
integer y = 248
integer width = 407
integer height = 100
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
date maxdate = Date("2999-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2020-10-15"), Time("17:11:49.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type st_2 from statictext within w_calculo_coste_articulo
integer x = 69
integer y = 264
integer width = 2459
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Recalculará el CF solo de los artículos que tengan partes  de fab. POSTERIORES a:"
boolean focusrectangle = false
end type

type cbx_encajado from checkbox within w_calculo_coste_articulo
integer x = 1193
integer y = 772
integer width = 795
integer height = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cálculo Coste Encajado"
boolean lefttext = true
end type

type cb_2 from commandbutton within w_calculo_coste_articulo
integer x = 1659
integer y = 1564
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Borrar"
end type

event clicked;datetime fecha
boolean fallo = false
long mes, anyo


//if messagebox ("Atención", "Desa borrar los datos de esta fecha", Question!, YesNo!, 2) = 1  then
if messagebox ("Atención", "Se borrarán los datos de este mes en cuestión y del mes siguiente", Question!, YesNo!, 2) = 1  then
	
	
	fecha = datetime(dp_fecha.text)

	mes = month(date(fecha))
	anyo = year(date(fecha))
	
	
	if trim(uo_articulo.em_codigo.text) <> '' then
		
		delete from articulos_coste
		where empresa = :codigo_empresa
		and month(fecha) = :mes
		and year(fecha) = :anyo
		and articulo = :uo_articulo.em_codigo.text
		using SQLCA;


		if SQLCA.SQLCode <> 0 THEN 
			fallo = true
		end if

	
		if mes = 12 then	
			mes = 1
			anyo = anyo + 1
		else
			mes = mes + 1
		end if

		delete from articulos_coste
		where empresa = :codigo_empresa
		and month(fecha) = :mes
		and year(fecha) = :anyo
		and articulo = :uo_articulo.em_codigo.text
		using SQLCA;
	
		if SQLCA.SQLCode <> 0 THEN 
			fallo = true
		end if
		
	
	else
		
		delete from articulos_coste
		where empresa = :codigo_empresa
		and month(fecha) = :mes
		and year(fecha) = :anyo
		using SQLCA;
	
		if SQLCA.SQLCode <> 0 THEN 
			fallo = true
		end if
		
		if mes = 12 then	
			mes = 1
			anyo = anyo + 1
		else
			mes = mes + 1
		end if
	
		delete from articulos_coste
		where empresa = :codigo_empresa
		and month(fecha) = :mes
		and year(fecha) = :anyo
		using SQLCA;
	
		if SQLCA.SQLCode <> 0 THEN 
			fallo = true
		end if
		
	end if
		
	
	if not fallo then
		commit using SQLCA;
		messagebox("Exito", "Al borrar los registros")
	else 
		rollback using SQLCA;
		messagebox("Error", "Al borrar los registros")
	end if
end if


end event

type st_regs from statictext within w_calculo_coste_articulo
integer x = 9
integer y = 964
integer width = 3118
integer height = 76
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 24076881
long backcolor = 67108864
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_calculo_coste_articulo
integer x = 814
integer y = 1320
integer width = 1394
integer height = 88
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 19474154
long backcolor = 67108864
string text = "Grabar coste en la tabla de histórico"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_calculo_coste_articulo
integer x = 1659
integer y = 1432
integer width = 402
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Calcular"
end type

event clicked;
datastore datos
string sel
long i, total_regs
string articulo
dec{6}  coste_mp, coste_fab, coste_mp_mermas, coste_fab_mermas, coste_compras, coste_packing, v_coste_total, coste_estimado
boolean fallo = false
datetime fecha, fecha_proximo_mes, fecha_proximo_mes_aux
dec {6} coste_acum_mp, coste_acum_fab, coste_acum_packing, coste_acum_compras
time inicio, ahora, fin
string filtro_articulo, uso
long registros, articulo_existente
boolean continuar
boolean coste_merma 
long mes, total, anyo

fecha = datetime(dp_fecha.text)
mes = month(date(fecha))
anyo = year(date(fecha))

//fecha_proximo_mes = datetime("01/"+string(1+mes)+"/"+string(anyo))

fecha_proximo_mes_aux = datetime("01/"+string(mes)+"/"+string(anyo))

//PARA CALCULAR EL ÚLTIMO DÍA DEL MES DE DESPUÉS, COJO EL MES SIGUIENTE Y LE RESTO UN DÍA	

SELECT DATEADD(month,2,:fecha_proximo_mes_aux) into :fecha_proximo_mes_aux from empresas where empresa = :codigo_empresa;

//fecha_proximo_mes_aux =  datetime("01/"+string(mes+2)+"/"+string(anyo))

SELECT DATEADD(day,-1,:fecha_proximo_mes_aux) into :fecha_proximo_mes from empresas where empresa = :codigo_empresa;


continuar = true


if trim(uo_articulo.em_codigo.text) = '' then
	
	select count(*)
	into :total
	from articulos_coste
	where month(fecha) = :mes
	and year(fecha) = :anyo
	and articulos_coste.empresa = :codigo_empresa;

	if total > 0 then
		messagebox ("Aviso" ,"Debe borrar los registros existentes a esa fecha antes de volverlos a generar")
		continuar = false
	end if
	
	filtro_articulo = ""
	
else
	
	filtro_articulo = " and articulos.codigo = '"+uo_articulo.em_codigo.text+"' "
	
	delete from articulos_coste 
	where empresa = :codigo_empresa
	and month(fecha) = :mes
	and year(fecha) = :anyo
	and articulo = :uo_articulo.em_codigo.text
	using sqlca;
	
	if mes = 12 then	
		mes = 1
		anyo = anyo + 1
	else
		mes = mes + 1
	end if

	delete from articulos_coste
	where empresa = :codigo_empresa
	and month(fecha) = :mes
	and year(fecha) = :anyo
	and articulo = :uo_articulo.em_codigo.text
	using SQLCA;
	
	IF SQLCA.SQLCode = -1 THEN 
		fallo = true
		MessageBox("Borrado SQL ", SQLCA.SQLErrText)		
	end if
	
end if

if continuar then
	if messagebox ("Atención", "Se recalcularán los costes a esa fecha. ¿Desea continuar?", Question!, YesNo!, 2) = 1  then
		
		sel = " Select art_ver_operaciones.articulo, isnull( art_ver_operaciones.coste_mp, 0) coste_mp, articulos.uso, "+&
				" isnull (art_ver_operaciones.coste_fab, 0) coste_fab, isnull(art_ver_operaciones.coste_mp_mermas, 0 ) coste_mp_mermas, "+& 
				" isnull(art_ver_operaciones.coste_fab_mermas, 0) coste_fab_mermas, isnull(art_ver_operaciones.coste_packing, 0) coste_packing, "+& 
				" isnull (art_ver_operaciones.coste_packing, 0 ) coste_packing,  "+&
				" ( case when (articulos.cant_compras is null or articulos.cant_compras = 0)   "+&
				"		then 0  "+&
				"		else (comartpro.precio / articulos.cant_compras)  "+&
				"	end ) coste_compras  "+&
				" from art_ver_operaciones "+&
				" left outer join articulos on art_ver_operaciones.empresa = articulos.empresa and art_ver_operaciones.articulo = articulos.codigo   "+&
				" left outer join venmprima on articulos.empresa = venmprima.empresa   "+&
				" 						and articulos.codigo_compras = venmprima.codigo  "+&
				" left outer join comartpro on venmprima.empresa = comartpro.empresa  "+&
				" 						and venmprima.codigo = comartpro.mprima   "+&
				" 						and comartpro.proveedor = ( select top 1 C2.proveedor   "+&
				" 													from comartpro  C2   "+&
				" 													where C2.empresa = comartpro.empresa   "+&
				" 													and C2.mprima = comartpro.mprima   "+&
				" 													order by precio asc) "+&
				" where art_ver_operaciones.empresa = '"+codigo_empresa+"' "+&
				" and art_ver_operaciones.version = '1' "+&
				" and articulos.fecha_anulado is null "+ filtro_articulo
		
		total_regs = f_cargar_cursor_transaccion (sqlca,datos,sel)
		
		inicio = now()

		for i = 1 to total_regs
			articulo = datos.object.art_ver_operaciones_articulo[i]
			coste_mp = datos.object.coste_mp[i]
			coste_fab = datos.object.coste_fab[i]
			coste_mp_mermas = datos.object.coste_mp_mermas[i]
			coste_fab_mermas = datos.object.coste_fab_mermas[i]
			coste_compras = datos.object.coste_compras[i]
			coste_packing = datos.object.coste_packing[i]
			uso = datos.object.articulos_uso[i]
			
			coste_merma = true
			coste_acum_mp = 0
			coste_acum_fab = 0
			coste_acum_packing = 0
			coste_acum_compras = 0
/*******************************************************************************************************************************************************/			
			if uso = '3' then
				f_calculo_coste_articulo_mp_fab_packing_compras ( codigo_empresa, articulo, coste_acum_mp, coste_acum_fab, coste_merma, coste_acum_packing, coste_acum_compras)
				v_coste_total = coste_acum_mp + coste_acum_fab + coste_acum_packing +coste_acum_compras //+ coste_estr 		
			end if

/*********************************************************************************************************************************************************/			

			//MES ACTUAL

			insert into articulos_coste (empresa, articulo, fecha, coste_mp, coste_fab, coste_mp_mermas, coste_fab_mermas, coste_compras, coste_packing, coste_acum_mp, coste_acum_fab, coste_acum_packing, coste_acum_compras)
			values (:codigo_empresa, :articulo, :fecha, :coste_mp, :coste_fab, :coste_mp_mermas, :coste_fab_mermas, :coste_compras, :coste_packing, :coste_acum_mp, :coste_acum_fab, :coste_acum_packing, :coste_acum_compras) 
			using sqlca;
			
			
			IF SQLCA.SQLCode <> 0 THEN 
				MessageBox("Inserción SQL", SQLCA.SQLErrText)
				fallo = true
			end if
			
			//MES SIGUIENTE
			
			insert into articulos_coste (empresa, articulo, fecha, coste_mp, coste_fab, coste_mp_mermas, coste_fab_mermas, coste_compras, coste_packing, coste_acum_mp, coste_acum_fab, coste_acum_packing, coste_acum_compras)
			values (:codigo_empresa, :articulo, :fecha_proximo_mes, :coste_mp, :coste_fab, :coste_mp_mermas, :coste_fab_mermas, :coste_compras, :coste_packing, :coste_acum_mp, :coste_acum_fab, :coste_acum_packing, :coste_acum_compras) 
			using sqlca;
			
			
			IF SQLCA.SQLCode <> 0 THEN 
				MessageBox("Inserción SQL", SQLCA.SQLErrText)
				fallo = true
			end if
	
			ahora = now()
			if mod (i, 10 ) = 0 then
				fin = Relativetime (inicio, ( SecondsAfter ( inicio, ahora ) / i ) * total_regs)
			end if
			st_regs.text = "Coste Operacion: " +string(i)+" de "+string(total_regs)+" | Inicio: "+String(Inicio)+" Fin: "+String(fin)
			if mod (i, 10 ) = 0 then
				parent.SetRedraw(true)
			end if		
	
			if not fallo then
				commit using SQLCA;
			else 
				rollback using SQLCA;
			end if
		
		next
		destroy datos	
	end if	
end if



// Añadimos el coste_Estimado a los articulos que lo tengan

sel = " select codigo, coste_estimado "+&
		" from articulos  "+&
		" where uso = '3'  "+&
		" and coste_estimado > 0  "+&
		" and coste_estimado is not NULL "+&
		" and articulos.fecha_anulado is NULL "
		
total_regs =  f_cargar_cursor_transaccion (sqlca,datos,sel)

for i = 1 to total_regs
	
	articulo = datos.object.codigo[i]
	coste_estimado = datos.object.coste_estimado[i]

	select count(*)
	into :articulo_existente
	from articulos_coste
	where articulos_coste.articulo = :articulo
	and articulos_coste.empresa = :codigo_empresa;
	
	if articulo_existente = 0 then
		
		insert into articulos_coste (empresa, articulo, fecha, coste_mp, coste_fab, coste_mp_mermas, coste_fab_mermas, coste_compras, coste_packing, coste_acum_mp, coste_acum_fab, coste_acum_packing, coste_acum_compras, coste_estimado)
		values (:codigo_empresa, :articulo, :fecha, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, :coste_estimado) 
		using sqlca;
		
		IF SQLCA.SQLCode <> 0 THEN 
				MessageBox("Introducción coste estimado", SQLCA.SQLErrText)
				fallo = true
		END IF
		
		insert into articulos_coste (empresa, articulo, fecha, coste_mp, coste_fab, coste_mp_mermas, coste_fab_mermas, coste_compras, coste_packing, coste_acum_mp, coste_acum_fab, coste_acum_packing, coste_acum_compras, coste_estimado)
		values (:codigo_empresa, :articulo, :fecha_proximo_mes, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, :coste_estimado) 
		using sqlca;
		
		IF SQLCA.SQLCode <> 0 THEN 
				MessageBox("Introducción coste estimado", SQLCA.SQLErrText)
				fallo = true
		END IF
		
	else
		
		update articulos_coste
		set coste_estimado = :coste_estimado
		where articulos_coste.articulo = :articulo
		and articulos_coste.empresa = :codigo_empresa
		and fecha = :fecha;
		
		IF SQLCA.SQLCode <> 0 THEN 
				MessageBox("Introducción coste estimado", SQLCA.SQLErrText)
				fallo = true
		END IF
		
		update articulos_coste
		set coste_estimado = :coste_estimado
		where articulos_coste.articulo = :articulo
		and articulos_coste.empresa = :codigo_empresa
		and fecha = :fecha_proximo_mes;
		
		IF SQLCA.SQLCode <> 0 THEN 
				MessageBox("Introducción coste estimado", SQLCA.SQLErrText)
				fallo = true
		END IF
		
	end if
	
	/*
	IF SQLCA.SQLCode <> 0 THEN 
				MessageBox("Introducción coste estimado", SQLCA.SQLErrText)
				fallo = true
	end if
	
	*/
	
	ahora = now()
	if mod (i, 10 ) = 0 then
		fin = Relativetime (inicio, ( SecondsAfter ( inicio, ahora ) / i ) * total_regs)
	end if
	st_regs.text = "Incorporando coste estimado: " +string(i)+" de "+string(total_regs)+" | Inicio: "+String(Inicio)+" Fin: "+String(fin)
	if mod (i, 10 ) = 0 then
		parent.SetRedraw(true)
	end if		
	
	if not fallo then
		commit using SQLCA;
	else 
		rollback using SQLCA;
	end if
next
destroy datos




end event

type dp_fecha from datepicker within w_calculo_coste_articulo
integer x = 1047
integer y = 1440
integer width = 539
integer height = 100
integer taborder = 30
boolean border = true
borderstyle borderstyle = stylelowered!
date maxdate = Date("2999-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2020-10-15"), Time("17:11:49.000000"))
integer textsize = -10
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type st_proceso from statictext within w_calculo_coste_articulo
boolean visible = false
integer x = 512
integer y = 224
integer width = 1426
integer height = 136
integer textsize = -18
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15793151
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_mensaje from statictext within w_calculo_coste_articulo
boolean visible = false
integer y = 1060
integer width = 3141
integer height = 108
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 24076881
long backcolor = 19474154
boolean border = true
boolean focusrectangle = false
end type

type pb_salir from picturebutton within w_calculo_coste_articulo
integer x = 3049
integer y = 48
integer width = 110
integer height = 96
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "Exit!"
alignment htextalign = right!
string powertiptext = "Salir"
end type

event clicked;close(parent)
end event

type pb_ejecutar from picturebutton within w_calculo_coste_articulo
integer x = 2930
integer y = 48
integer width = 110
integer height = 96
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "Run!"
alignment htextalign = right!
string powertiptext = "Ejecutar"
end type

event clicked;
// codigo_error = 1 Fallo al calcular el coste de fabricación.
// codigo_error = 2 Fallo al calcular el coste de mermas.

string ruta = '1'
string mensaje, mensaje1,mensaje2, mensaje3, sel, articulo, articulo_ini
boolean fallo
integer codigo_error = 0
datastore datos, datos2, datos3
long i, j, total
dec costePacking

if cbx_fab.checked  or  cbx_mermas.checked or cbx_encajado.checked then
	if uo_articulo.em_codigo.text <> '' then
		articulo_ini = uo_articulo.em_codigo.text
	else
		articulo_ini = '%'
	end if
	// Construcción del mensaje de Aviso
	if cbx_fab.checked then
		mensaje1 = "Cálculo coste de fabricación."
	end if
	if cbx_mermas.checked then
		mensaje2 = "Cálculo coste de la Mermas."
	end if
	if cbx_encajado.checked then
		mensaje3 = "Cálculo coste de Encajados."
	end if
	
	mensaje = mensaje1 + mensaje2 + mensaje3 +  " ¿Desea Continuar?"
	
	
	if MessageBox("Atención", mensaje, Question!, OKCancel!, 2) = 1 THEN
		connect using SQLCA;

/*
		sel = " Select codigo " +&
				" from articulos "+&
				" where empresa = '"+codigo_empresa+"' " +&
				" and codigo like '"+articulo_ini+"' "
	*/			
		sel = " Select distinct articulo as codigo " +&
				" from prodpartes_ot "+&
				" where empresa = '"+codigo_empresa+"' " +&
				" and fecha >= '"+dp_fecha_Calculo.text+"' "+&
				" and articulo like '"+articulo_ini+"' "
				
	
		total = f_cargar_cursor_transaccion (sqlca,datos,sel)
		
		st_proceso.visible = true
		st_mensaje.visible = true

		// Si no hay partes de producción, ponemos el coste de fabricacion a 0
		if total = 0 and uo_articulo.em_codigo.text <> '' then
			if cbx_fab.checked then
				update art_ver_operaciones 
				set coste_fab = 0
				where empresa = :codigo_empresa and articulo = :uo_articulo.em_codigo.text using sqlca; 
			end if
		end if	
	
		for i = 1 to total
			articulo = datos.object.codigo[i]
			if cbx_fab.checked then
				fallo = f_calculo_coste_fab_articulo (codigo_empresa, articulo, ruta)
				if fallo then codigo_error = 1 
			end if
			st_proceso.text = "COSTE FABRICACIÓN"
			st_mensaje.text = string(i) + " / "+ string(datos.rowcount())
		next 
		
		if codigo_error = 0 then
			commit using SQLCA;
		elseif codigo_error = 1 then
			rollback using SQLCA;
			messagebox ("Error", "Ha fallado el cálculo del coste de Fabricación::: "+SQLCA.SQLErrText, StopSign!)
		end if		
		destroy datos
		connect using SQLCA;
	/*	
		sel = " Select codigo " +&
				" from articulos "+&
				" where empresa = '"+codigo_empresa+"' " +&
				" and uso = '3' "+&
				" and codigo like '"+articulo_ini+"' "
*/
		sel = " Select distinct articulo as codigo " +&
				" from prodpartes_ot "+&
				" inner join articulos on prodpartes_ot.empresa = articulos.empresa and prodpartes_ot.articulo = articulos.codigo "+&
				" where prodpartes_ot.empresa = '"+codigo_empresa+"' " +&
				" and articulos.uso = '3' "+&
				" and prodpartes_ot.fecha >= '"+dp_fecha_Calculo.text+"' "+&
				" and prodpartes_ot.articulo like '"+articulo_ini+"' "
	
		total = f_cargar_cursor_transaccion (sqlca,datos2,sel)
		
		for j = 1 to total
			articulo = datos2.object.codigo[j]
			
			if cbx_mermas.checked  and not fallo then
				fallo = f_calculo_coste_mermas (codigo_empresa, articulo, ruta)
//				fallo = f_calculo_coste_mermas_trans (codigo_empresa, articulo, ruta , trans_sql)
				if fallo then codigo_error = 2
			end if
			st_proceso.text = "COSTE MERMAS"
			st_mensaje.text = string(j) + " / "+ string(datos2.rowcount())
		next 	

		if codigo_error = 0 then
			commit using SQLCA;
		elseif codigo_error = 2 then
			rollback using SQLCA;
			messagebox ("Error", "Ha fallado el cálculo del coste de Mermas::: "+SQLCA.SQLErrText, StopSign!)
		end if
		destroy datos2
	/*	
		sel = " Select codigo " +&
				" from articulos "+&
				" where empresa = '"+codigo_empresa+"' " +&
				" and uso = '3' "+&
				" and codigo like '"+articulo_ini+"' "
*/
		sel = " Select distinct articulo as codigo " +&
				" from prodpartes_ot "+&
				" inner join articulos on prodpartes_ot.empresa = articulos.empresa and prodpartes_ot.articulo = articulos.codigo "+&
				" where prodpartes_ot.empresa = '"+codigo_empresa+"' " +&
				" and prodpartes_ot.fecha >= '"+dp_fecha_Calculo.text+"' "+&
				" and articulos.uso = '3' "+&
				" and prodpartes_ot.articulo like '"+articulo_ini+"' "				
	
		total = f_cargar_cursor_transaccion (sqlca,datos3,sel)
		
		for j = 1 to total
			articulo = datos3.object.codigo[j]
		
			st_proceso.text = "COSTE ENCAJADO"
			st_mensaje.text = string(j) + " / "+ string(datos3.rowcount())
			if cbx_encajado.checked then
				costePacking = f_calculo_coste_packing (codigo_empresa, articulo )
				update art_ver_operaciones 
				set coste_packing = :costePacking 
				where empresa = :codigo_empresa and articulo = :articulo using sqlca; 
			end if
		next 	
		
		// Si no hay partes de un artículo y queremos calcular el coste de su packing
		if total = 0 and uo_articulo.em_codigo.text <> '' then
			if cbx_encajado.checked then
				costePacking = f_calculo_coste_packing (codigo_empresa, uo_articulo.em_codigo.text )
				update art_ver_operaciones 
				set coste_packing = :costePacking 
				where empresa = :codigo_empresa and articulo = :uo_articulo.em_codigo.text using sqlca; 
			end if
		end if
		
	


		if codigo_error = 0 then
			commit using SQLCA;
		elseif codigo_error = 2 then
			rollback using SQLCA;
			messagebox ("Error", "Ha fallado el cálculo del coste de encajados::: "+SQLCA.SQLErrText, StopSign!)
		end if
		destroy datos3
	end if
else
	messagebox ("Atención", "No ha seleccionado niguna opción de cálculo.",Exclamation!)
end if



st_proceso.visible = false
st_mensaje.visible = false

		




end event

type uo_articulo from u_em_campo_2 within w_calculo_coste_articulo
event destroy ( )
integer x = 46
integer y = 56
integer width = 1559
integer height = 88
integer taborder = 10
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_articulo.em_campo.text=f_nombre_articulo(codigo_empresa,uo_articulo.em_codigo.text)
IF Trim(uo_articulo.em_campo.text)="" THEN 
 IF Trim(uo_articulo.em_codigo.text)<>"" Then uo_articulo.em_campo.SetFocus()
 uo_articulo.em_campo.text=""
 uo_articulo.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de articulos"
ue_datawindow = "dw_ayuda_articulos"
ue_filtro     = ""

end event

type cbx_mermas from checkbox within w_calculo_coste_articulo
integer x = 933
integer y = 632
integer width = 1056
integer height = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cálculo Coste Mermas (Fab y Mp)"
boolean lefttext = true
end type

type cbx_fab from checkbox within w_calculo_coste_articulo
integer x = 1143
integer y = 512
integer width = 846
integer height = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cálculo Coste Fabricación"
boolean lefttext = true
end type

type gb_1 from groupbox within w_calculo_coste_articulo
integer x = 786
integer y = 1224
integer width = 1440
integer height = 532
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_5 from groupbox within w_calculo_coste_articulo
integer x = 2903
integer width = 270
integer height = 160
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_2 from groupbox within w_calculo_coste_articulo
integer x = 23
integer y = 4
integer width = 1605
integer height = 160
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Articulo"
end type

type gb_3 from groupbox within w_calculo_coste_articulo
integer x = 791
integer y = 420
integer width = 1440
integer height = 584
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

