// src/items/items.service.ts
import { Injectable, Inject } from '@nestjs/common';
import { Client } from 'pg';  // pgのClient型をインポート
import { Item } from './items.model';  // Itemインターフェースをインポート
import { CreateItemDto } from './dto/create-items.dto';  // CreateItemDtoをインポート
import { UpdateItemDto } from './dto/update-items.dto';  // UpdateItemDtoをインポート

@Injectable()
export class ItemsService {
  constructor(
    @Inject('PG_CLIENT') private readonly client: Client,  // pgクライアントのインジェクト
  ) {}

  // アイテムを全件取得
  async findAll(): Promise<Item[]> {
    const res = await this.client.query('SELECT * FROM items');
    return res.rows;  // 結果の行を返す
  }

  // アイテムをIDで検索
  async findById(id: number): Promise<Item | null> {
    const res = await this.client.query('SELECT * FROM items WHERE id = $1', [id]);
    return res.rows[0] || null;  // 結果がなければnullを返す
  }

  // アイテムの作成
  async create(createItemDto: CreateItemDto): Promise<Item> {
    const { title, description, status } = createItemDto;
    const res = await this.client.query(
      'INSERT INTO items (title, description, status) VALUES ($1, $2, $3) RETURNING *',
      [title, description, status],
    );
    return res.rows[0];  // 作成したアイテムを返す
  }

  // アイテムの更新
  async update(id: number, updateItemDto: UpdateItemDto): Promise<Item | null> {
    const { title, description, status } = updateItemDto;
    const res = await this.client.query(
      'UPDATE items SET title = $1, description = $2, status = $3 WHERE id = $4 RETURNING *',
      [title, description, status, id],
    );
    return res.rows[0] || null;  // 更新後のアイテムを返す
  }

  // アイテムの削除
  async delete(id: number): Promise<boolean> {
    const res = await this.client.query('DELETE FROM items WHERE id = $1', [id]);
    return res.rowCount > 0;  // 削除が成功した場合にtrueを返す
  }
}



